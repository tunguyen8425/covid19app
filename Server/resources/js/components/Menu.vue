<template>
    <nav class="navbar horizontal-layout col-lg-12 col-12 p-0">
			<div class="nav-top flex-grow-1">
				<div class="container d-flex flex-row h-100">
					<div class="text-center navbar-brand-wrapper d-flex align-items-center">
						<a class="navbar-brand brand-logo" href="/"><img src="images/logo.png" alt="logo" /></a>
						<a class="navbar-brand brand-logo-mini" href="/"><img src="images/logo.png" alt="logo" /></a>
					</div>
					<div class="navbar-menu-wrapper d-flex align-items-stretch justify-content-between flex-grow-1">
						<ul class="navbar-nav navbar-nav-right mr-0 ml-auto">
							<li class="nav-item">
								<a class="nav-link">
									<span class="nav-profile-name">Hello Admin!</span>
								</a>
							</li>
              <li v-if="!$auth.check()" class="nav-item">
                <router-link to="/register" >
                    <i class="icon-user-follow text-primary mr-2"></i> Register
                </router-link>
              </li>
              <li v-if="!$auth.check()" class="nav-item">
                <router-link to="/login" >
                    <i class="icon-login text-primary mr-2"></i> Login
                </router-link>
              </li>
              <li v-if="$auth.check()" class="nav-item">
                <a href="#" @click.prevent="$auth.logout()"><i class="icon-logout text-primary mr-2"></i> Logout</a>
              </li>
						</ul>
					</div>
				</div>
			</div>
			<div class="nav-bottom">
				<div class="container">
					<ul class="nav page-navigation">
						<li class="nav-item">
							<router-link to="/user" class="nav-link"><i class="link-icon icon-people"></i><span class="menu-title">User</span></router-link>
						</li>
            <li class="nav-item">
              <router-link to="/hospital" class="nav-link"><i class="link-icon icon-home"></i><span class="menu-title">Hospital</span></router-link>
            </li>
						<li class="nav-item">
							<router-link to="/covid-19" class="nav-link"><i class="link-icon icon-note"></i><span class="menu-title">Covid-19</span></router-link>
						</li>
						<li class="nav-item">
							<router-link to="/survey" class="nav-link"><i class="link-icon icon-note"></i><span class="menu-title">Survey</span></router-link>
						</li>
						<li class="nav-item">
							<router-link to="/settings" class="nav-link"><i class="link-icon icon-settings"></i><span class="menu-title">Settings</span></router-link>
						</li>
					</ul>
				</div>
			</div>
		</nav>
</template>

<script>
  export default {
    data() {
      return {
        routes: {
          // UNLOGGED
          unlogged: [
            {
              name: 'Register',
              path: 'register'
            },
            {
              name: 'Login',
              path: 'login'
            }
          ],

          // LOGGED USER
          user: [
            {
              name: 'Dashboard',
              path: 'dashboard'
            }
          ],
          // LOGGED ADMIN
          admin: [
            {
              name: 'Dashboard',
              path: 'admin.dashboard'
            }
          ]
        }
      }
    },
    mounted() {
      //
    }
  }
</script>
