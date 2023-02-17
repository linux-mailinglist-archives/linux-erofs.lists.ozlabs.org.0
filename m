Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C04C69A648
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Feb 2023 08:54:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PJ3x20qz8z3f37
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Feb 2023 18:54:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jccFety1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jccFety1;
	dkim-atps=neutral
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PJ3wx2CmSz3cfY
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Feb 2023 18:54:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676620449; x=1708156449;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KKRJJP3lr1LqH4aXnJABylM6EktUHF7oQJ+JOlqiEHU=;
  b=jccFety1K6COrsgNnuaHAjqSO2S5LwGQ020yRgtpDBNQEsje/dIzwu+b
   K4+wBBDyDkmwGySMyFMo4JPFMGTM32IIt7XhKjGSaBmMmITb2Rdf/yjbG
   6vOQzheC1ibMOmytjaygVLC6yghI52gO8fKwF1ohb2vBkWkqY1jlpaqrg
   P7LRYA14njxqH54TN1PgNehXx2qAcklaJyaQxsH0FraPqnCy/0jLexGzu
   Hzr6sKdFUnjj1HJXPJ3imI2eO6R/EVIoJy01udsD9vlgMynCP1WDz8flh
   sSy8OJ5LJPmn9BNJJWbRG7cakWhBr6Z2yfx9hw5WhEeykCgwMCkDq3mJh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="359382718"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="359382718"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 23:54:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="915989883"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="915989883"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2023 23:54:02 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pSvZC-000BD9-15;
	Fri, 17 Feb 2023 07:54:02 +0000
Date: Fri, 17 Feb 2023 15:53:28 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 8d1b80a79452630f157bf634ae9cfcd9f4eed161
Message-ID: <63ef3278.Q+RPlFwo3GpkRXxB%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 8d1b80a79452630f157bf634ae9cfcd9f4eed161  erofs: fix an error code in z_erofs_init_zip_subsystem()

elapsed time: 995m

configs tested: 95
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                             allnoconfig
alpha                            allyesconfig
alpha                               defconfig
arc                               allnoconfig
arc                              allyesconfig
arc                                 defconfig
arc                  randconfig-r043-20230212
arc                  randconfig-r043-20230213
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                                 defconfig
arm                  randconfig-r046-20230212
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                 randconfig-a011-20230213
i386                          randconfig-a012
i386                 randconfig-a012-20230213
i386                 randconfig-a013-20230213
i386                          randconfig-a014
i386                 randconfig-a014-20230213
i386                 randconfig-a015-20230213
i386                          randconfig-a016
i386                 randconfig-a016-20230213
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                randconfig-r042-20230213
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                 randconfig-r044-20230213
sh                               allmodconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                        randconfig-a011
x86_64               randconfig-a011-20230213
x86_64               randconfig-a012-20230213
x86_64                        randconfig-a013
x86_64               randconfig-a013-20230213
x86_64               randconfig-a014-20230213
x86_64                        randconfig-a015
x86_64               randconfig-a015-20230213
x86_64               randconfig-a016-20230213
x86_64                               rhel-8.3

clang tested configs:
arm                  randconfig-r046-20230213
hexagon              randconfig-r041-20230212
hexagon              randconfig-r041-20230213
hexagon              randconfig-r045-20230212
hexagon              randconfig-r045-20230213
i386                 randconfig-a001-20230213
i386                 randconfig-a002-20230213
i386                 randconfig-a003-20230213
i386                 randconfig-a004-20230213
i386                 randconfig-a005-20230213
i386                 randconfig-a006-20230213
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20230212
s390                 randconfig-r044-20230212
x86_64               randconfig-a001-20230213
x86_64               randconfig-a002-20230213
x86_64               randconfig-a003-20230213
x86_64               randconfig-a004-20230213
x86_64               randconfig-a005-20230213
x86_64               randconfig-a006-20230213
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
