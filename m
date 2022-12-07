Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E4291645E54
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 17:04:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NS2CR5nNCz3bg9
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Dec 2022 03:04:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LoUuMlFX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LoUuMlFX;
	dkim-atps=neutral
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NS2CF226qz3bYD
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Dec 2022 03:03:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670429033; x=1701965033;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=93RKvhghOEk4APzMu3FQ5y1PENCnss7CBObM00cQhKU=;
  b=LoUuMlFX3Sgpz4ZbZ4Nt8RUfbAFlO2losdza7tLRxc39BNgxnZDfic+W
   zscIZZkiYPVTH2k/Nz7iqzRqQJJxlPimVMezwxDi/hbCrQUar5Li+oFSS
   NSePOYEqJEox9SeWmFix8Gjq2tW4Q7Ogg8lzQsTVQzH2RHrkPlltlC9pJ
   bFdNk4PXw795IZGv5taPBLAU5wGc5zv/EbcRRcYg8JdI/R+q/vYnjIOCb
   +grevYXa6PZs6AKpRR7Nt1pNCCdEiRDcmeJQPRpxtI+H2z/Ug2YH03nRn
   ZUKWhD9O+c5LMaTj29YrbX56nTpkhz6EuPd2jr75XRZhrikmnUjJ2cxic
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="343961750"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="343961750"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 08:03:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="677413389"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="677413389"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Dec 2022 08:03:10 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p2wt4-0000Ng-0E;
	Wed, 07 Dec 2022 16:03:10 +0000
Date: Thu, 08 Dec 2022 00:02:38 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 2a1af528ab46a4bb007852a1df623c5e5616cde2
Message-ID: <6390b91e.wuRE2oA33OWOYBJ7%lkp@intel.com>
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
branch HEAD: 2a1af528ab46a4bb007852a1df623c5e5616cde2  erofs/zmap.c: Bail out when no further region remains

elapsed time: 723m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                                 defconfig
alpha                               defconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
i386                          randconfig-a014
i386                          randconfig-a012
s390                             allyesconfig
i386                          randconfig-a016
x86_64                          rhel-8.3-rust
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
mips                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
x86_64                        randconfig-a006
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
arm                  randconfig-r046-20221206
arc                  randconfig-r043-20221206
i386                          randconfig-a005
arm                                 defconfig
i386                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a013
arc                              allyesconfig
alpha                            allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
s390                 randconfig-r044-20221207
arc                  randconfig-r043-20221207
riscv                randconfig-r042-20221207
x86_64                            allnoconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
hexagon              randconfig-r041-20221206
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r045-20221206
s390                 randconfig-r044-20221206
riscv                randconfig-r042-20221206
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
