Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F5B33E01E
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Mar 2021 22:15:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F0QzY1H6zz309Z
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Mar 2021 08:15:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0QzS62T1z2xgF
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Mar 2021 08:14:55 +1100 (AEDT)
IronPort-SDR: LCX3lpAfD0fPCEMQZdkdS46nAtQ9rXKaiY3I3twN8/HDXZnEEfFYHKket6R0TD0Kl6Bw0WBKu2
 sppWK/VhJ3DQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="176932154"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; d="scan'208";a="176932154"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2021 14:14:50 -0700
IronPort-SDR: C+F50nc12kEfTAeNLBYbFl+sAQwXRpmVmWzCjVGy+LD1oPAsJQV7s/OnlqAye2Kk5PC+HROuup
 yNR2frngXwZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; d="scan'208";a="522629704"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 16 Mar 2021 14:14:49 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lMH1c-0000JR-AG; Tue, 16 Mar 2021 21:14:48 +0000
Date: Wed, 17 Mar 2021 05:14:20 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 f8e769f774034432a4cd8ccdc331586224989657
Message-ID: <60511fac.YM3FvTTwzK5zRIxB%lkp@intel.com>
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
branch HEAD: f8e769f774034432a4cd8ccdc331586224989657  erofs: avoid memory allocation failure during rolling decompression

elapsed time: 723m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
mips                           ip27_defconfig
nds32                             allnoconfig
powerpc                      arches_defconfig
sh                           se7343_defconfig
powerpc                           allnoconfig
alpha                            alldefconfig
sh                   secureedge5410_defconfig
arm                        magician_defconfig
xtensa                       common_defconfig
powerpc                        icon_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                    vt8500_v6_v7_defconfig
sh                           se7722_defconfig
m68k                         apollo_defconfig
sh                             espt_defconfig
arm                      footbridge_defconfig
powerpc                     taishan_defconfig
arm                         shannon_defconfig
m68k                            q40_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         mv78xx0_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                          iss_defconfig
powerpc                     tqm8540_defconfig
arm                          moxart_defconfig
powerpc                        fsp2_defconfig
mips                        nlm_xlr_defconfig
ia64                             alldefconfig
arm                          imote2_defconfig
arc                          axs103_defconfig
powerpc                     tqm8541_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                mpc7448_hpc2_defconfig
riscv                          rv32_defconfig
sh                          rsk7201_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     powernv_defconfig
m68k                       m5208evb_defconfig
mips                      pistachio_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                       aspeed_g5_defconfig
arm                            dove_defconfig
arm                  colibri_pxa270_defconfig
arm                       multi_v4t_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      obs600_defconfig
xtensa                  audio_kc705_defconfig
arm                          collie_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                               tinyconfig
i386                                defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20210316
i386                 randconfig-a003-20210316
i386                 randconfig-a004-20210316
i386                 randconfig-a006-20210316
x86_64               randconfig-a016-20210316
x86_64               randconfig-a015-20210316
x86_64               randconfig-a011-20210316
x86_64               randconfig-a013-20210316
x86_64               randconfig-a014-20210316
x86_64               randconfig-a012-20210316
i386                 randconfig-a013-20210316
i386                 randconfig-a016-20210316
i386                 randconfig-a011-20210316
i386                 randconfig-a012-20210316
i386                 randconfig-a015-20210316
i386                 randconfig-a014-20210316
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210316
x86_64               randconfig-a001-20210316
x86_64               randconfig-a005-20210316
x86_64               randconfig-a004-20210316
x86_64               randconfig-a003-20210316
x86_64               randconfig-a002-20210316

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
