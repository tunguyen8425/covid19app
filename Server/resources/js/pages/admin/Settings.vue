<template>
    <div class="container">
        <div class="card card-default">
            <div class="card-header">
                <h3>Settings</h3>
            </div>
            <div class="card-body">
                <settingList></settingList>
            </div>
        </div>
    </div>
</template>
<script>
    import settingList from '../../components/settingList.vue'
    export default {
        mounted() {
            //
        },
        components: {
            settingList
        }
    }
</script>
