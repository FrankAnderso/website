subroutine power_series_approximation(f, A, max_iter, tol, q, converged, iterations, m)
  ! Calculate a power series approximation for q in the equation:
  !
  !   q = (I - A) ^ (-1) . f
  !
  ! using:
  !
  !   q = f + A . f + A^2 . f + A^3 . f + ... + A^n . f
  !
  ! Inputs
  ! ------
  ! f : m-length vector of 8-byte / double precision reals
  !     Vector of final demand
  ! A : (m x m) array of 8-byte / double precision reals
  !     Input-output matrix
  ! max_iter : integer
  !     Maximum number of iterations to run for
  ! tol : 8-byte / double precision real
  !     Threshold for convergence
  ! m : integer
  !     Length of `f` and `A`
  !
  ! Outputs
  ! -------
  ! q : m-length vector of 8-byte / double precision reals
  !     Vector of gross output
  ! converged : logical
  !     `.true.` if procedure converged; `.false.` otherwise
  ! iterations : integer
  !     Number of iterations run for
  !
  implicit none

  integer, intent(in) :: m

  real(8), dimension(m), intent(in) :: f
  real(8), dimension(m, m), intent(in) :: A

  integer, intent(in) :: max_iter
  real(8), intent(in) :: tol

  real(8), dimension(m), intent(out) :: q
  logical, intent(out) :: converged
  integer, intent(out) :: iterations

  real(8), dimension(m) :: term

  ! Copy `f` to initialise the series
  q = f
  term = f

  converged = .false.

  do iterations = 1, max_iter
     ! Calculate the next term in the series and add it to `q`
     term = matmul(A, term)
     q = q + term

     ! Test for convergence
     if(sum(term * term) < tol) then
        converged = .true.
        exit
     end if

  end do

end subroutine power_series_approximation
