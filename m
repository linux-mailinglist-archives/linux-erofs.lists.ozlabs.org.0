Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC1C48E8BE
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jan 2022 11:58:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JZywG12DYz30KR
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jan 2022 21:58:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IaEpkrju;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IaEpkrju; dkim-atps=neutral
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JZyw90JDpz2ylk
 for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jan 2022 21:58:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642157929; x=1673693929;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=O3zl5qKOTATR9TMDMudTfdeFOQ34aY3ZTvRTWHpRsDw=;
 b=IaEpkrjud7UimGs5qJsrbafRDdCZyXS22uiZJzmdvraLZBGBX909xx2N
 gOU5fPKtTXsrSV0/MrlGCCUHLBGGIPnep/75jrKkem2dCLAM8fdiqRhU9
 p7XCbVjz4ZWpW5O+GkHLzaRDYcRT3OxDpAZ9bHhr5gD278w7zOXExjv2n
 cxVpClFsCbMSLGFEJcdc9+yPRHtxF0AYVnF+V0N+qmkJ8n1eBtrD97R4g
 PmdOcwBTWBvoVyVuTW+4DqZzeQzFNT7uqjFu3qtODzegjAKWQ6OgfOhTp
 WKC42ruR9//XhKEYihvNFqrSLF1iSCppMoS+I6bHO3EnGRLPDhMR3W1I6 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244022157"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; d="scan'208";a="244022157"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 02:57:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; d="scan'208";a="614296480"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2022 02:57:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1n8KH7-0008Qp-R2; Fri, 14 Jan 2022 10:57:41 +0000
Date: Fri, 14 Jan 2022 18:56:45 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 804d01326f6f5921390c72710453934716370cb2
Message-ID: <61e156ed.09oGUydg3AthNbuU%lkp@intel.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 804d01326f6f5921390c72710453934716370cb2  erofs: fix fsdax partition offset handling

elapsed time: 863m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                          gemini_defconfig
arm                         at91_dt_defconfig
nios2                         10m50_defconfig
sparc64                             defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc837x_mds_defconfig
sh                 kfr2r09-romimage_defconfig
sh                               alldefconfig
m68k                       m5208evb_defconfig
openrisc                 simple_smp_defconfig
m68k                        mvme16x_defconfig
powerpc                     tqm8555_defconfig
arm                            hisi_defconfig
mips                       capcella_defconfig
arm                         axm55xx_defconfig
arm                           h5000_defconfig
powerpc                    amigaone_defconfig
arc                        nsim_700_defconfig
sh                        sh7757lcr_defconfig
sh                          landisk_defconfig
csky                             alldefconfig
xtensa                          iss_defconfig
arm                           sunxi_defconfig
powerpc                      pasemi_defconfig
sh                               j2_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
powerpc                      tqm8xx_defconfig
arm                          iop32x_defconfig
mips                         tb0226_defconfig
arm                            mps2_defconfig
arm                          lpd270_defconfig
riscv                            allmodconfig
arm                            qcom_defconfig
arm                            pleb_defconfig
ia64                        generic_defconfig
sh                   rts7751r2dplus_defconfig
s390                          debug_defconfig
sh                          rsk7264_defconfig
sh                          r7785rp_defconfig
arm                            xcep_defconfig
sh                           se7343_defconfig
xtensa                    xip_kc705_defconfig
arc                    vdk_hs38_smp_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
m68k                             allmodconfig
sh                              ul2_defconfig
arm                  randconfig-c002-20220113
arm                  randconfig-c002-20220114
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220113
arc                  randconfig-r043-20220113
s390                 randconfig-r044-20220113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220113
x86_64                        randconfig-c007
riscv                randconfig-c006-20220113
powerpc              randconfig-c003-20220113
i386                          randconfig-c001
mips                 randconfig-c004-20220113
mips                           ip28_defconfig
arm                          pxa168_defconfig
powerpc                     powernv_defconfig
powerpc                        icon_defconfig
mips                        bcm63xx_defconfig
powerpc                     mpc5200_defconfig
mips                            e55_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220113
hexagon              randconfig-r041-20220113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
