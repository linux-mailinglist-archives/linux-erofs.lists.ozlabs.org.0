Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E29CB645E53
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 17:04:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NS2CM5cjdz3bh0
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Dec 2022 03:03:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jm4OsILY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jm4OsILY;
	dkim-atps=neutral
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NS2CF1w2zz3bVY
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Dec 2022 03:03:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670429033; x=1701965033;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UMPXzTOJg12Rxfo7jimLjif8A7hY3DLaM56OqlCg6nM=;
  b=jm4OsILYDjvaMaGVLJnu5f2YjgIXov06SJE01eZ337JQsMVVbc72a8xa
   I1Pzz3pdEjkG7m/zXnj7bqy2OIGlc1i3Q+IvX0zPugZMGSR8sIHOf9x0V
   WPHlZ3beFyZvnvqskasbUr5TptUmThzY69EqRf/PX6qHGXJ+iInJdVMGx
   w6tYBKdobifmvTPlsWfXBqSVujSP3kf8Uv8hErP79yw98sFVcGNNQxNNP
   bba/9etRcOrzWcGVDJb83dEUOM4Hr37GRDXfNN1/aV9kISxmeJPXUcWy7
   Dl8Op+OuL4CUInvdbRwNgzxhR6arh+oNNpBOg+cbj6VKPmi4C2YoBosmA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315638929"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="315638929"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 08:03:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="753153281"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="753153281"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2022 08:03:10 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p2wt3-0000Nb-1M;
	Wed, 07 Dec 2022 16:03:09 +0000
Date: Thu, 08 Dec 2022 00:02:33 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 e5293c693d68f705787480159c4cd332c09c5e67
Message-ID: <6390b919.lvwwtf/ih40LgydW%lkp@intel.com>
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
branch HEAD: e5293c693d68f705787480159c4cd332c09c5e67  erofs: validate the extent length for uncompressed pclusters

elapsed time: 723m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                          rhel-8.3-rust
powerpc                           allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                                defconfig
x86_64                              defconfig
alpha                            allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a014
i386                          randconfig-a005
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
x86_64                           allyesconfig
arm                                 defconfig
mips                             allyesconfig
i386                          randconfig-a016
powerpc                          allmodconfig
arm                  randconfig-r046-20221206
arc                  randconfig-r043-20221206
arm64                            allyesconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
s390                 randconfig-r044-20221207
arc                  randconfig-r043-20221207
riscv                randconfig-r042-20221207
x86_64                            allnoconfig

clang tested configs:
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a004
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a006
hexagon              randconfig-r041-20221206
hexagon              randconfig-r045-20221206
s390                 randconfig-r044-20221206
riscv                randconfig-r042-20221206
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
