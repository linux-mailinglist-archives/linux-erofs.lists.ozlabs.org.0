Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2207320C1
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 22:15:42 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SDH1e0up;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qhtp45RS0z3bTk
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jun 2023 06:15:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SDH1e0up;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 972 seconds by postgrey-1.37 at boromir; Fri, 16 Jun 2023 06:15:33 AEST
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qhtnx0CTyz2xqp
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jun 2023 06:15:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686860133; x=1718396133;
  h=date:from:to:cc:subject:message-id;
  bh=JAYWOE1JPfhe+AMZDEgXFK6ftLlCULpTMHBlsHcjJsk=;
  b=SDH1e0upj9Da8x6NtXOP+MXY4anKeQ+DDFTobEJQhoGx820M1XHpq4kS
   qm2B0s1SLXLZGVrEfVJSWYKjI86ZZ5NDu+CRiT50vUtrhPtSEET8uU7+K
   qbHRtKKZbAxHIv/Jgjx/Q/d85SDkKjkJLZtqtoJAtCVnfE8fvL/ucgOTB
   e75j77x7nFb+QKTPHnj5lzJOWudV17pd/O17J5tVG0jG+XwqcNn8QEeFa
   E/ymcoxnoThIIniYbU0B7XcOgtKYWyva3mNlnxnfiJ0LzcRv2bnhyekm0
   0RvyA82DnL+EsGash4uhbut99JXSrC1mN7jtLqOKHASDgHjhkiXTRw6Td
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424953070"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="424953070"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 12:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="712569284"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="712569284"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2023 12:43:48 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q9ssl-0000KR-2O;
	Thu, 15 Jun 2023 19:43:47 +0000
Date: Fri, 16 Jun 2023 03:43:40 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 746f921a85ca11ef1d697b20c574dcadaba8da59
Message-ID: <202306160338.J9HNGMaz-lkp@intel.com>
User-Agent: s-nail v14.9.24
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 746f921a85ca11ef1d697b20c574dcadaba8da59  erofs: clean up zmap.c

elapsed time: 722m

configs tested: 76
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230614   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r032-20230615   gcc  
alpha                randconfig-r036-20230615   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230614   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230615   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r022-20230615   gcc  
arm                  randconfig-r046-20230615   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r004-20230615   clang
hexagon              randconfig-r041-20230615   clang
hexagon              randconfig-r045-20230615   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230615   gcc  
loongarch            randconfig-r015-20230614   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r026-20230615   gcc  
m68k                 randconfig-r034-20230615   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r021-20230615   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230615   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230614   gcc  
powerpc              randconfig-r011-20230614   gcc  
powerpc              randconfig-r031-20230615   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r001-20230614   gcc  
riscv        buildonly-randconfig-r004-20230614   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230614   gcc  
riscv                randconfig-r025-20230615   clang
riscv                randconfig-r042-20230615   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230614   gcc  
s390                 randconfig-r023-20230615   clang
s390                 randconfig-r044-20230615   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230614   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230615   gcc  
sparc64              randconfig-r001-20230615   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230614   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
