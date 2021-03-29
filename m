Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C034D38B
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 17:16:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8GQJ3qrHz3021
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 02:16:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8GQF4Ztmz2y0G
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Mar 2021 02:16:47 +1100 (AEDT)
IronPort-SDR: gfmFsj7wU5TD3HxKcOEzZLDv2AwSiWEXvZommbwSBOc9F+tTVTEH3Vfl9z9yZglac4ARIfiWg/
 9Lp8L8TzwoYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191597422"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; d="scan'208";a="191597422"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2021 08:16:44 -0700
IronPort-SDR: 6zARfanXlzA8LcTA4NKzsFLFBDiD1BV+HaTJ5BnNwzdN6/nhEMKNOlu71sy4zVglL9DNKN4dFF
 bCwkZvwCtHyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; d="scan'208";a="444811475"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 08:16:43 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lQtdC-0004c5-Dd; Mon, 29 Mar 2021 15:16:42 +0000
Date: Mon, 29 Mar 2021 23:16:00 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 0b964600d3aae56ff9d5bdd710a79f39a44c572c
Message-ID: <6061ef30.2hR76/0yXOsabIuk%lkp@intel.com>
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
branch HEAD: 0b964600d3aae56ff9d5bdd710a79f39a44c572c  erofs: complete a missing case for inplace I/O

elapsed time: 727m

configs tested: 151
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
sh                        sh7763rdp_defconfig
arm                         lpc32xx_defconfig
m68k                          atari_defconfig
sh                           se7712_defconfig
arc                        nsim_700_defconfig
arc                           tb10x_defconfig
arm                        keystone_defconfig
powerpc                     akebono_defconfig
powerpc                    adder875_defconfig
sh                         microdev_defconfig
arm                        multi_v7_defconfig
powerpc                      chrp32_defconfig
arm                       omap2plus_defconfig
sh                          rsk7264_defconfig
x86_64                           allyesconfig
riscv                    nommu_virt_defconfig
um                            kunit_defconfig
arm                  colibri_pxa300_defconfig
s390                          debug_defconfig
arm                        mvebu_v5_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                  mpc885_ads_defconfig
arm                       aspeed_g4_defconfig
riscv                    nommu_k210_defconfig
arm                       cns3420vb_defconfig
sh                           sh2007_defconfig
powerpc                    sam440ep_defconfig
sh                      rts7751r2d1_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    xip_kc705_defconfig
arm                            pleb_defconfig
powerpc                        fsp2_defconfig
arm                        mini2440_defconfig
arm                     am200epdkit_defconfig
arm                           tegra_defconfig
mips                      pistachio_defconfig
openrisc                 simple_smp_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc8560_ads_defconfig
sh                          r7785rp_defconfig
m68k                       bvme6000_defconfig
arm                             pxa_defconfig
sh                         ap325rxa_defconfig
mips                        maltaup_defconfig
powerpc                      katmai_defconfig
powerpc                     pq2fads_defconfig
m68k                            q40_defconfig
arm                           h5000_defconfig
sh                        edosk7760_defconfig
mips                       lemote2f_defconfig
sh                        sh7757lcr_defconfig
arc                      axs103_smp_defconfig
powerpc                      ppc6xx_defconfig
arm                           spitz_defconfig
arm                         s3c2410_defconfig
arm                      jornada720_defconfig
powerpc                         ps3_defconfig
mips                            ar7_defconfig
sh                          sdk7786_defconfig
powerpc                     rainier_defconfig
sh                            migor_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210329
x86_64               randconfig-a003-20210329
x86_64               randconfig-a006-20210329
x86_64               randconfig-a001-20210329
x86_64               randconfig-a005-20210329
x86_64               randconfig-a004-20210329
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a001-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
x86_64               randconfig-a015-20210328
x86_64               randconfig-a012-20210328
x86_64               randconfig-a013-20210328
x86_64               randconfig-a014-20210328
x86_64               randconfig-a016-20210328
x86_64               randconfig-a011-20210328
i386                 randconfig-a014-20210329
i386                 randconfig-a011-20210329
i386                 randconfig-a015-20210329
i386                 randconfig-a016-20210329
i386                 randconfig-a013-20210329
i386                 randconfig-a012-20210329
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210328
x86_64               randconfig-a003-20210328
x86_64               randconfig-a001-20210328
x86_64               randconfig-a006-20210328
x86_64               randconfig-a005-20210328
x86_64               randconfig-a004-20210328
x86_64               randconfig-a015-20210329
x86_64               randconfig-a012-20210329
x86_64               randconfig-a013-20210329
x86_64               randconfig-a014-20210329
x86_64               randconfig-a011-20210329
x86_64               randconfig-a016-20210329

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
