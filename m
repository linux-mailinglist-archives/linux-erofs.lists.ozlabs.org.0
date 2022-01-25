Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DF649AFBF
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jan 2022 10:17:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jjh8c4GlXz3bP4
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jan 2022 20:17:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lIqxVKNU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lIqxVKNU; dkim-atps=neutral
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jjh8T1W3Rz2xtF
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jan 2022 20:17:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643102265; x=1674638265;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=4vrOOwmfznbdofPLNtiDKe9Q1ulNvaEiQEdOCzMNm2Y=;
 b=lIqxVKNUB1wjP+U0gPOD8aHgeRIttOoQ8SMs+vBHbXhdS61izaupxdYT
 2Q69yyHJr9VCE+J7xoYfqdBRNsUUkskHXaOg37937qztLthCMCBp/tVBC
 5dc5MyGzuCDX4PijLfG0vI53dZlfmhmq24EPU/ParWTT6eBJP2IqBGrbG
 CoEzy5zugMc9fuQJeli7ZFACZuU8A4MvONPKvakIeCRCjDIFEhkSwGe+C
 ZfrFe2XDQBgGQ03AVQKsIDeMjcIzEXKuYQz7spMcL74gOwe4e2Az0inyH
 dg0WGrHnf9TQzZ8SXSdIiekpsLLOLqhGfKxlFacQL9WxCiHOzOib5/7H2 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="306977455"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="306977455"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2022 01:16:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="520316928"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 25 Jan 2022 01:16:33 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nCHwH-000Jd5-2y; Tue, 25 Jan 2022 09:16:33 +0000
Date: Tue, 25 Jan 2022 17:16:17 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 7865827c432bf9885ee26e5767697c3d9e21a82c
Message-ID: <61efbfe1.y2Fk5qp0+Vq06yBl%lkp@intel.com>
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
branch HEAD: 7865827c432bf9885ee26e5767697c3d9e21a82c  erofs: avoid unnecessary z_erofs_decompressqueue_work() declaration

elapsed time: 727m

configs tested: 135
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
sh                           se7722_defconfig
mips                     decstation_defconfig
sparc                       sparc64_defconfig
powerpc                      ppc6xx_defconfig
mips                            gpr_defconfig
arc                          axs101_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     asp8347_defconfig
sh                          kfr2r09_defconfig
nios2                         10m50_defconfig
powerpc                     sequoia_defconfig
arm                           h5000_defconfig
riscv                    nommu_k210_defconfig
m68k                          atari_defconfig
openrisc                            defconfig
csky                                defconfig
powerpc                     tqm8548_defconfig
sh                           se7206_defconfig
arm                        mvebu_v7_defconfig
arm                           viper_defconfig
sh                   sh7724_generic_defconfig
mips                         bigsur_defconfig
ia64                        generic_defconfig
sh                           sh2007_defconfig
arm                          simpad_defconfig
sh                          r7780mp_defconfig
mips                  maltasmvp_eva_defconfig
sh                             shx3_defconfig
arm                            lart_defconfig
sparc64                          alldefconfig
arm                            pleb_defconfig
mips                            ar7_defconfig
arm                       aspeed_g5_defconfig
arm                  randconfig-c002-20220124
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
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
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
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
arc                  randconfig-r043-20220124
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
mips                     cu1000-neo_defconfig
arm                           sama7_defconfig
powerpc                     kmeter1_defconfig
mips                        bcm63xx_defconfig
powerpc                          g5_defconfig
arm                          imote2_defconfig
powerpc                     mpc5200_defconfig
powerpc                     tqm8560_defconfig
mips                     cu1830-neo_defconfig
arm                        neponset_defconfig
mips                           ip22_defconfig
arm                     davinci_all_defconfig
powerpc                      ppc44x_defconfig
arm                              alldefconfig
arm                          moxart_defconfig
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
s390                 randconfig-r044-20220124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
