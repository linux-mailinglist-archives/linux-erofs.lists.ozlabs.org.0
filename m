Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E665E691184
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 20:45:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PCS592102z3f2x
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Feb 2023 06:45:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ca66NQjo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ca66NQjo;
	dkim-atps=neutral
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PCS506ldbz30QD
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Feb 2023 06:45:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675971909; x=1707507909;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UnvQjdtfZXbfQjAMJTqVwHxe0SxprVGt/HLF6WrAjvo=;
  b=ca66NQjojkv7PDA2SPr1dWtKoKSIZna1VFQ6iSB8v73FFNQsU7kJ/U5S
   2FVAolG4/Mybt797W6BRUuZ0G4DEJsvMGHEPFcZBllThvP+zFW452+0AN
   RrWVMatzy1c0FS47zCt6WewHWNwnT1IWw1wNuc0st9EtOXEF34D4BV6yo
   LRpk/h/uvfG8Xy0T94NN13y1pRUcC6xMJpDbBve0WyV2wMejdgiAxMHFH
   Let7JR28SKtcYOR3J8aVxMbMIolt8eQGubDdR6otqLQKkryd7foyxWsyQ
   KPD0xnDGFG85Smt10fT3kLf4m/eaUDubr/324IsaHuhg6mzVud98W1PaC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="327917862"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="327917862"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 11:44:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="996667204"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="996667204"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Feb 2023 11:44:57 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pQCqn-0005Gs-0M;
	Thu, 09 Feb 2023 19:44:57 +0000
Date: Fri, 10 Feb 2023 03:44:19 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 944e4bd7beeb68ce2eae4d5c3e5c0ef554311679
Message-ID: <63e54d13./HkMwYR0H8D4X7/3%lkp@intel.com>
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
branch HEAD: 944e4bd7beeb68ce2eae4d5c3e5c0ef554311679  erofs: unify anonymous inodes for blob

elapsed time: 726m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                                defconfig
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                               rhel-8.3
arc                                 defconfig
ia64                             allmodconfig
alpha                               defconfig
arc                               allnoconfig
arm                                 defconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
i386                          randconfig-a001
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a013
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
s390                                defconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
i386                          randconfig-a005
x86_64                           allyesconfig
x86_64                        randconfig-a015
s390                             allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20230209
arm                  randconfig-r046-20230209
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arm64                            allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r041-20230209
x86_64                        randconfig-a014
hexagon              randconfig-r045-20230209
x86_64                        randconfig-a016
i386                          randconfig-a006
s390                 randconfig-r044-20230209
riscv                randconfig-r042-20230209
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
