Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32B452C629
	for <lists+linux-erofs@lfdr.de>; Thu, 19 May 2022 00:19:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L3S7s5ttGz3bff
	for <lists+linux-erofs@lfdr.de>; Thu, 19 May 2022 08:19:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hWQDYisk;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hWQDYisk; dkim-atps=neutral
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L3S7n1Wbkz2yMj
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 May 2022 08:18:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652912341; x=1684448341;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=bW3Yx2vQ4jWUABnsZLiUpRTldyDgjlt1iTwExahZAk8=;
 b=hWQDYiskf2oFOL3Q7KZxluy346Y5lpP9LOjWZZj2yDBGowbY0Ndwq3kk
 SL2tuSmTqsSRZ/QfEEPqrRv8rJ0n+//jwiaXrHduutgiCiPbR0XUx+jVQ
 mrXf/v6SgNBYEjAlYr9UzjVc6jba/EN61Dl7s3NC31CQJwwI/8b3qUgrY
 zTn85WFPg11xRWvEjcmt0nfhZIunyuIYcwtlqxbYhIFMmKOfiqUW4pBO4
 eHp/vR9dnaW+Qey6rH3DQHKXedbQn4tANB0P6aaXSuK0ZeUjx47ggDTc/
 db5zD/4odYBI5KhDtBKpI2J8+rpED5oYJuuxptEDtEQaVCgUi+ml4viMU w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="271869273"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="271869273"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 15:18:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="639494529"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
 by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 15:18:52 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nrS0J-0002gi-Pw;
 Wed, 18 May 2022 22:18:51 +0000
Date: Thu, 19 May 2022 06:18:08 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 ba73eadd23d1c2dc5c8dc0c0ae2eeca2b9b709a7
Message-ID: <628570a0.OZ2lSvAwKJ/oSZVa%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: ba73eadd23d1c2dc5c8dc0c0ae2eeca2b9b709a7  erofs: scan devices from device table

elapsed time: 1771m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
i386                 randconfig-c001-20220516
arm                        multi_v7_defconfig
sh                           se7780_defconfig
arm                      jornada720_defconfig
sh                           se7721_defconfig
mips                  decstation_64_defconfig
powerpc                      pasemi_defconfig
mips                            gpr_defconfig
m68k                       m5249evb_defconfig
sh                           se7206_defconfig
arm                          pxa3xx_defconfig
sh                   sh7724_generic_defconfig
arm                          pxa910_defconfig
sh                           sh2007_defconfig
mips                       capcella_defconfig
m68k                        m5307c3_defconfig
m68k                          amiga_defconfig
sh                           se7751_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64               randconfig-a012-20220516
x86_64               randconfig-a011-20220516
x86_64               randconfig-a013-20220516
x86_64               randconfig-a014-20220516
x86_64               randconfig-a015-20220516
x86_64               randconfig-a016-20220516
i386                 randconfig-a015-20220516
i386                 randconfig-a016-20220516
i386                 randconfig-a012-20220516
i386                 randconfig-a011-20220516
i386                 randconfig-a013-20220516
i386                 randconfig-a014-20220516
arc                  randconfig-r043-20220516
s390                 randconfig-r044-20220516
riscv                randconfig-r042-20220516
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
arm                         palmz72_defconfig
powerpc                     pseries_defconfig
powerpc                        icon_defconfig
arm                   milbeaut_m10v_defconfig
mips                           mtx1_defconfig
x86_64               randconfig-a002-20220516
x86_64               randconfig-a001-20220516
x86_64               randconfig-a003-20220516
x86_64               randconfig-a005-20220516
x86_64               randconfig-a004-20220516
x86_64               randconfig-a006-20220516
i386                 randconfig-a003-20220516
i386                 randconfig-a001-20220516
i386                 randconfig-a004-20220516
i386                 randconfig-a006-20220516
i386                 randconfig-a002-20220516
i386                 randconfig-a005-20220516
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
hexagon              randconfig-r045-20220516
hexagon              randconfig-r041-20220516

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
