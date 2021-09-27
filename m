Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC7041A3D7
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 01:35:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJJt44qBrz2yP9
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 09:35:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJJsx3frKz2yLZ
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Sep 2021 09:35:43 +1000 (AEST)
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="224621558"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; d="scan'208";a="224621558"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 16:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; d="scan'208";a="478402871"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
 by fmsmga007.fm.intel.com with ESMTP; 27 Sep 2021 16:34:35 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mV08m-0000hV-Vb; Mon, 27 Sep 2021 23:34:32 +0000
Date: Tue, 28 Sep 2021 07:34:27 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:fixes] BUILD SUCCESS
 c40dd3ca2a45d5bd6e8b3f4ace5cb81493096263
Message-ID: <61525503.kihenBdZL4YiYFm2%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
branch HEAD: c40dd3ca2a45d5bd6e8b3f4ace5cb81493096263  erofs: clear compacted_2b if compacted_4b_initial > totalidx

elapsed time: 720m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20210927
mips                     cu1830-neo_defconfig
m68k                       m5249evb_defconfig
parisc                generic-64bit_defconfig
arc                          axs103_defconfig
sh                          r7780mp_defconfig
mips                     decstation_defconfig
arm                             rpc_defconfig
arm                           sunxi_defconfig
arm                         nhk8815_defconfig
mips                           ip27_defconfig
arc                              alldefconfig
sh                           se7343_defconfig
mips                        bcm63xx_defconfig
nds32                            alldefconfig
arc                        vdk_hs38_defconfig
powerpc                      pasemi_defconfig
sh                          kfr2r09_defconfig
mips                           ci20_defconfig
sh                           se7721_defconfig
x86_64               randconfig-c001-20210927
arm                  randconfig-c002-20210927
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
nios2                               defconfig
nds32                             allnoconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210927
x86_64               randconfig-a006-20210927
x86_64               randconfig-a001-20210927
x86_64               randconfig-a005-20210927
x86_64               randconfig-a004-20210927
x86_64               randconfig-a003-20210927
i386                 randconfig-a001-20210927
i386                 randconfig-a005-20210927
i386                 randconfig-a006-20210927
i386                 randconfig-a002-20210927
i386                 randconfig-a003-20210927
i386                 randconfig-a004-20210927
arc                  randconfig-r043-20210927
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20210927
x86_64               randconfig-c007-20210927
mips                 randconfig-c004-20210927
arm                  randconfig-c002-20210927
riscv                randconfig-c006-20210927
s390                 randconfig-c005-20210927
i386                 randconfig-c001-20210927
x86_64               randconfig-a014-20210927
x86_64               randconfig-a011-20210927
x86_64               randconfig-a013-20210927
x86_64               randconfig-a016-20210927
x86_64               randconfig-a015-20210927
x86_64               randconfig-a012-20210927
i386                 randconfig-a014-20210927
i386                 randconfig-a013-20210927
i386                 randconfig-a016-20210927
i386                 randconfig-a012-20210927
i386                 randconfig-a015-20210927
i386                 randconfig-a011-20210927
hexagon              randconfig-r045-20210927
riscv                randconfig-r042-20210927
hexagon              randconfig-r041-20210927
s390                 randconfig-r044-20210927

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
