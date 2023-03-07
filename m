Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5356AF18E
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Mar 2023 19:45:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PWPXH47dxz3cht
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Mar 2023 05:45:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nCOhVAMm;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nCOhVAMm;
	dkim-atps=neutral
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PWPX749Mbz3cMN
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Mar 2023 05:45:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678214727; x=1709750727;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=i7GOvADt5k5Ng327RhfmKnjcL1h1PzZ4Xp8s7ivUNgU=;
  b=nCOhVAMm39a/SOPxvCmYsUCigX/UNuLMDXTTYReJydze2puFEjP0oq9b
   wsKL1+4vu44Wu8Do7yDw5EjVWqcWvAwjQdrEZWO0GCAw8BvH5tdGjy8sR
   22BBFrWVU9g9XU1vaKjVGBarChjlMjboeXnVUf10g5+f65EwZ8L9QcTHs
   c1WzvunVvVUQc7BluJW3jKqzN5zQ0hs1chHdhJJXLH9Ya+dMIGzKKIQHm
   joqQgcQF5tDAE4hPHILH8D5f3N1UAgg9CRV3mxWlXC0V/OODz6xsayaNR
   hIf36539rTR+kfAnyoy1VRr5fq92JwHbIsHURsBJjKP/r8LyYS6z9W2nl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334653057"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="334653057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 10:45:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="819863646"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="819863646"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2023 10:45:16 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pZcJH-0001Ww-2E;
	Tue, 07 Mar 2023 18:45:15 +0000
Date: Wed, 08 Mar 2023 02:44:33 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:fixes] BUILD SUCCESS
 83cf6dd6c187e6796de4c0faa39b2595dcbbe99a
Message-ID: <64078611.cwZquNep+85h6Brw%lkp@intel.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
branch HEAD: 83cf6dd6c187e6796de4c0faa39b2595dcbbe99a  erofs: use wrapper i_blocksize() in erofs_file_read_iter()

elapsed time: 731m

configs tested: 123
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230305   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230305   gcc  
arm                  randconfig-r021-20230306   gcc  
arm                  randconfig-r036-20230306   clang
arm                  randconfig-r046-20230305   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230305   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230305   gcc  
csky                 randconfig-r014-20230306   gcc  
hexagon      buildonly-randconfig-r001-20230305   clang
hexagon      buildonly-randconfig-r002-20230305   clang
hexagon              randconfig-r002-20230305   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r045-20230305   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
i386                 randconfig-r032-20230306   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230306   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230305   gcc  
loongarch            randconfig-r015-20230305   gcc  
loongarch            randconfig-r021-20230305   gcc  
loongarch            randconfig-r032-20230305   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r006-20230306   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230305   gcc  
microblaze           randconfig-r013-20230305   gcc  
microblaze           randconfig-r026-20230305   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r004-20230306   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r033-20230305   gcc  
openrisc     buildonly-randconfig-r006-20230305   gcc  
openrisc             randconfig-r013-20230306   gcc  
openrisc             randconfig-r014-20230305   gcc  
openrisc             randconfig-r016-20230306   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230306   gcc  
parisc               randconfig-r024-20230305   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230305   gcc  
powerpc      buildonly-randconfig-r005-20230305   gcc  
powerpc      buildonly-randconfig-r005-20230306   clang
powerpc              randconfig-r025-20230306   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230305   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230305   clang
s390                 randconfig-r033-20230306   gcc  
s390                 randconfig-r036-20230305   clang
s390                 randconfig-r044-20230305   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230305   gcc  
sh                   randconfig-r011-20230306   gcc  
sh                   randconfig-r012-20230306   gcc  
sh                   randconfig-r031-20230306   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r023-20230306   gcc  
sparc64              randconfig-r025-20230305   gcc  
sparc64              randconfig-r035-20230306   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64               randconfig-r015-20230306   clang
x86_64               randconfig-r024-20230306   clang
x86_64               randconfig-r026-20230306   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230306   gcc  
xtensa               randconfig-r011-20230305   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
