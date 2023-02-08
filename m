Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696CE68FA41
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 23:29:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PBvn51MCLz3f36
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 09:29:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AeBNpF49;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AeBNpF49;
	dkim-atps=neutral
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PBvmy0n1Yz2yXL
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 09:29:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675895362; x=1707431362;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=saqGow/ixAchjErA5/y8Ujw3hzW1NeHtGf0rSmMoBsA=;
  b=AeBNpF49ReUlAEHovZhenSVtJFcRTcsXaf+sN7KyZFRfu9Jdkl5mv1Ne
   iT8k4uLYQT4az9CNWf7ZE8wRVT3fW7l5DJZbACI8e1EG2GkSNFadM5alI
   dNTFailGwS9mD90IEFfU4Y2cQhdnX448dbdRzs+f5+93uuzjquD6Xv8SK
   Pg4q4HkZlBrGkLuDsH5MNZmqzlaBIwv6/JjISFFEPHgZU8r896Os9c1Qp
   3v1029BdCqsiHAAmbqFbZ+TjKk8VADivDuwKKvD0iX7fQyurIGsMijHrc
   mfMz0pCz0n92KKQLJRy970AY93O/w4lgVeKneZc9FlyJigAOvACXOvOtF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="332068954"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="332068954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 14:29:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="697803408"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="697803408"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Feb 2023 14:29:16 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pPswF-0004gM-2q;
	Wed, 08 Feb 2023 22:29:15 +0000
Date: Thu, 09 Feb 2023 06:28:27 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 d8a650adf429722006c36ecb4e0782bdb4f166c9
Message-ID: <63e4220b.U9dD+F6c9qaKJg61%lkp@intel.com>
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
branch HEAD: d8a650adf429722006c36ecb4e0782bdb4f166c9  erofs: add per-cpu threads for decompression as an option

elapsed time: 723m

configs tested: 84
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                               rhel-8.3
arm                                 defconfig
i386                 randconfig-a011-20230206
s390                             allyesconfig
i386                 randconfig-a014-20230206
i386                 randconfig-a012-20230206
i386                 randconfig-a013-20230206
arc                  randconfig-r043-20230205
i386                                defconfig
s390                 randconfig-r044-20230206
i386                 randconfig-a015-20230206
i386                 randconfig-a016-20230206
arm                  randconfig-r046-20230205
arc                               allnoconfig
x86_64                           allyesconfig
alpha                             allnoconfig
i386                              allnoconfig
riscv                randconfig-r042-20230206
arm                               allnoconfig
arc                  randconfig-r043-20230206
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                           rhel-8.3-bpf
sh                               allmodconfig
ia64                             allmodconfig
x86_64                        randconfig-a011
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
mips                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arm64                            allyesconfig
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a001
i386                             allyesconfig
i386                          randconfig-a014
alpha                            allyesconfig
i386                          randconfig-a003
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a005

clang tested configs:
x86_64               randconfig-a002-20230206
x86_64               randconfig-a003-20230206
riscv                randconfig-r042-20230205
x86_64               randconfig-a006-20230206
x86_64               randconfig-a004-20230206
hexagon              randconfig-r045-20230206
x86_64               randconfig-a001-20230206
hexagon              randconfig-r041-20230206
s390                 randconfig-r044-20230205
x86_64               randconfig-a005-20230206
hexagon              randconfig-r045-20230205
x86_64                        randconfig-a016
hexagon              randconfig-r041-20230205
x86_64                        randconfig-a012
arm                  randconfig-r046-20230206
x86_64                        randconfig-a014
i386                 randconfig-a002-20230206
i386                 randconfig-a004-20230206
x86_64                          rhel-8.3-rust
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a006-20230206
i386                 randconfig-a005-20230206
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
