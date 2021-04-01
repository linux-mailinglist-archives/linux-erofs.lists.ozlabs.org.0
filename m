Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EC235171D
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 19:12:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FB8qk5dnGz2yxH
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Apr 2021 04:12:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB8qh3zRDz2yjN
 for <linux-erofs@lists.ozlabs.org>; Fri,  2 Apr 2021 04:11:58 +1100 (AEDT)
IronPort-SDR: r5iu+5oQod658dVdNAvMUHmevs7qB8IRrgP3A2igVtdbF/zSpZO/kSArQu1vZwFFuhm9BiVnHg
 fPMyLY4Zq5fA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179424934"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="179424934"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 10:11:55 -0700
IronPort-SDR: o+igVmQQ5zoJuQ9WFe7Kw0rukGdkFWiWHAl8V+ZcZTLbDz+vNZEyuKb14pNA8KEKKgiB1bE7Uh
 SkRRpe+TH94Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="456068468"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 01 Apr 2021 10:11:53 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lS0rJ-0006au-20; Thu, 01 Apr 2021 17:11:53 +0000
Date: Fri, 02 Apr 2021 01:11:51 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 342a714196aef1e1f53a606224ee4aaffd6ce4a8
Message-ID: <6065fed7.8OQtVqKAylXOx1pO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 342a714196aef1e1f53a606224ee4aaffd6ce4a8  erofs: enable big pcluster feature

elapsed time: 720m

configs tested: 174
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
sh                           se7705_defconfig
mips                         tb0219_defconfig
arm                     am200epdkit_defconfig
mips                           ip32_defconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
m68k                         amcore_defconfig
arm                       spear13xx_defconfig
arm                           viper_defconfig
um                            kunit_defconfig
xtensa                  cadence_csp_defconfig
powerpc                     akebono_defconfig
arm                           corgi_defconfig
sh                             sh03_defconfig
sh                              ul2_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                            q40_defconfig
arm                       netwinder_defconfig
powerpc                       ppc64_defconfig
xtensa                       common_defconfig
mips                 decstation_r4k_defconfig
mips                     cu1830-neo_defconfig
mips                     cu1000-neo_defconfig
mips                      pistachio_defconfig
mips                malta_kvm_guest_defconfig
sh                        edosk7760_defconfig
sh                               allmodconfig
alpha                               defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                                defconfig
m68k                         apollo_defconfig
arc                           tb10x_defconfig
arm                            dove_defconfig
arm                        multi_v7_defconfig
m68k                        mvme16x_defconfig
arm                       multi_v4t_defconfig
mips                          ath79_defconfig
arm                         shannon_defconfig
arm                       omap2plus_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      acadia_defconfig
powerpc                     mpc512x_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   motionpro_defconfig
arm                         axm55xx_defconfig
ia64                                defconfig
powerpc                      ppc6xx_defconfig
arm                         s5pv210_defconfig
powerpc                      ppc40x_defconfig
sh                          landisk_defconfig
arm                      integrator_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                                  defconfig
arm                        spear6xx_defconfig
sh                           se7722_defconfig
arm                          moxart_defconfig
mips                       capcella_defconfig
mips                    maltaup_xpa_defconfig
sh                     sh7710voipgw_defconfig
sh                          lboxre2_defconfig
powerpc                    ge_imp3a_defconfig
sh                         ap325rxa_defconfig
powerpc                     ep8248e_defconfig
arm                      footbridge_defconfig
arm                         orion5x_defconfig
mips                        qi_lb60_defconfig
mips                       rbtx49xx_defconfig
arm                           tegra_defconfig
xtensa                    xip_kc705_defconfig
powerpc                        fsp2_defconfig
sh                        apsh4ad0a_defconfig
arm                         lpc32xx_defconfig
arm                         socfpga_defconfig
powerpc                 linkstation_defconfig
mips                         tb0226_defconfig
m68k                           sun3_defconfig
ia64                            zx1_defconfig
mips                          malta_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
arm                          ixp4xx_defconfig
xtensa                generic_kc705_defconfig
arm                       cns3420vb_defconfig
m68k                        mvme147_defconfig
arm                              alldefconfig
sh                          rsk7203_defconfig
mips                           mtx1_defconfig
riscv                            alldefconfig
arm                            pleb_defconfig
mips                       lemote2f_defconfig
um                               allmodconfig
powerpc                     powernv_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         cm_x300_defconfig
sh                           se7751_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            shmin_defconfig
arm                          lpd270_defconfig
powerpc64                        alldefconfig
arc                        nsimosci_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210401
i386                 randconfig-a003-20210401
i386                 randconfig-a001-20210401
i386                 randconfig-a004-20210401
i386                 randconfig-a002-20210401
i386                 randconfig-a005-20210401
x86_64               randconfig-a014-20210401
x86_64               randconfig-a015-20210401
x86_64               randconfig-a011-20210401
x86_64               randconfig-a013-20210401
x86_64               randconfig-a012-20210401
x86_64               randconfig-a016-20210401
i386                 randconfig-a014-20210401
i386                 randconfig-a011-20210401
i386                 randconfig-a016-20210401
i386                 randconfig-a012-20210401
i386                 randconfig-a013-20210401
i386                 randconfig-a015-20210401
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
