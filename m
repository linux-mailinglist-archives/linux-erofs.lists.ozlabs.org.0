Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7975372B8
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 23:41:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LBBnG2rTsz30BK
	for <lists+linux-erofs@lfdr.de>; Mon, 30 May 2022 07:41:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B0bQnfZ4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B0bQnfZ4;
	dkim-atps=neutral
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LBBn40K33z2yjS
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 May 2022 07:41:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653860472; x=1685396472;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bLANoMWUv7wErv9p5ofXXdU7fU2BWpYgRDAFN0UnL0U=;
  b=B0bQnfZ4kKswcSnhMmKAjbq1dDN45J4lKPoiJlnKtpvCWXffdARSoMnr
   Qqf5aAAyGJf7QstCgxj/HyqNgi5y+Qfy50gDk1fiz4p14mLnUrous1hAr
   c0wjerEaAdHwh9nBEqRaDXJP1HjsLQNLjFul9fkHSGGQbSKKR+TdiiDAP
   ympHhqePhi3qqy1r5mIc9yaTv6F83ZzXuk5Vm2uIEpQN81avFOklAAWRY
   XiHTdXnqD+iiDJD/4AkawmDOWq7rCDQ2NxerWkIM5lbxvnj0oD66cpHeD
   L8eLCrLSp5ZJZfV3p/BV4he9tzsBXfeoqRm4k4jSmGgjLdm5iukik6IvC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="274564446"
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="274564446"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 14:41:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="705899853"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 May 2022 14:40:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1nvQeg-0001G4-UN;
	Sun, 29 May 2022 21:40:58 +0000
Date: Mon, 30 May 2022 05:40:27 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 e271f78c9cd2ee31938d8ff35ca72c46018ee8a1
Message-ID: <6293e84b.MP2Q30MQvd6OGhxb%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: e271f78c9cd2ee31938d8ff35ca72c46018ee8a1  erofs: simplify z_erofs_pcluster_readmore()

elapsed time: 754m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                           stm32_defconfig
arm                            xcep_defconfig
xtensa                           alldefconfig
powerpc                     sequoia_defconfig
powerpc                 mpc834x_mds_defconfig
arm                           corgi_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     redwood_defconfig
sh                              ul2_defconfig
sh                           se7721_defconfig
arm                       aspeed_g5_defconfig
powerpc                     tqm8541_defconfig
m68k                          atari_defconfig
sh                          r7785rp_defconfig
mips                             allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220529
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
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
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arc                  randconfig-r043-20220529
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
powerpc              randconfig-c003-20220529
x86_64                        randconfig-c007
arm                  randconfig-c002-20220529
mips                 randconfig-c004-20220529
i386                          randconfig-c001
s390                 randconfig-c005-20220529
riscv                randconfig-c006-20220529
powerpc                       ebony_defconfig
arm                           spitz_defconfig
powerpc                        icon_defconfig
powerpc                    socrates_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220529
hexagon              randconfig-r045-20220529
s390                 randconfig-r044-20220529
riscv                randconfig-r042-20220529

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
