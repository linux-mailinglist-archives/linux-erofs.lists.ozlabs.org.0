Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8786A64104C
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Dec 2022 23:01:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NP6NW0Y9hz3bfm
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Dec 2022 09:01:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Smh3r6lG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Smh3r6lG;
	dkim-atps=neutral
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NP6NP0f01z3bWF
	for <linux-erofs@lists.ozlabs.org>; Sat,  3 Dec 2022 09:01:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670018501; x=1701554501;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RKKQRvFwPlwuUQgc1/Z5zSAKAyVH2yYh0cgpL19MVmM=;
  b=Smh3r6lGT8OYFh1euypsLzRlKjDHpr8rwaT8SWWTVXSiW10BFW7CaBbR
   b4/6c9zzEiVByMaYgLnvm7jsiwu2whH/RWbEPLRZHNieDk4ZzcCDSZe5J
   yDxUvfqcGzUn+rBgAa9KeXbYQxQX5nz+SwL63u6K0XqURSiWciEvOVOcn
   tbb/zA5cb/FPM2NkDL6qZpj1OmFCnN2s+fDmO8lmPVzNCupLO77NafjVS
   mN1NmOpTj6jBT1zdgEiHRIgoiFPp7FWq6adRVXKalzj4zVxuo1eVThFyS
   OSHEW3K222Idfxh2tku7d78NhJdsIvOvWqpUDdOvz2lYCnJUxKrAJgHvc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="402333936"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="402333936"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="675974076"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="675974076"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2022 14:01:30 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p1E65-000E3u-2Y;
	Fri, 02 Dec 2022 22:01:29 +0000
Date: Sat, 03 Dec 2022 06:01:02 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 51e5be28a87d08a4f2890ee4edf8632092ca5a7d
Message-ID: <638a759e.W5hx/P75nH/W90ix%lkp@intel.com>
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
branch HEAD: 51e5be28a87d08a4f2890ee4edf8632092ca5a7d  erofs: use kmap_local_page() only for erofs_bread()

elapsed time: 773m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
alpha                             allnoconfig
i386                              allnoconfig
arc                               allnoconfig
arm                               allnoconfig
x86_64                        randconfig-a004
s390                 randconfig-r044-20221201
x86_64                        randconfig-a002
ia64                             allmodconfig
arc                                 defconfig
powerpc                           allnoconfig
alpha                               defconfig
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
x86_64                          rhel-8.3-func
sh                               allmodconfig
arc                              allyesconfig
mips                             allyesconfig
alpha                            allyesconfig
i386                          randconfig-a003
arc                  randconfig-r043-20221201
m68k                             allyesconfig
s390                             allmodconfig
powerpc                          allmodconfig
i386                          randconfig-a001
x86_64                               rhel-8.3
i386                          randconfig-a016
x86_64                           allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a013
s390                             allyesconfig
i386                          randconfig-a014
x86_64                        randconfig-a011
i386                          randconfig-a012
riscv                randconfig-r042-20221201
x86_64                        randconfig-a015
i386                                defconfig
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a006
hexagon              randconfig-r041-20221201
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a004
i386                          randconfig-a011
x86_64                        randconfig-a016
i386                          randconfig-a013
x86_64                        randconfig-a012
i386                          randconfig-a015
hexagon              randconfig-r045-20221201

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
