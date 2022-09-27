Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB85EB91A
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 06:04:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mc5c80ll0z3bqC
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 14:04:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j3Rs+IL/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j3Rs+IL/;
	dkim-atps=neutral
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mc5c241Wmz3bWM
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 14:04:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664251474; x=1695787474;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pei7bI4QKfY9UJ71X/susCZ+XEZp1ItYi+2oo1G95BU=;
  b=j3Rs+IL/8tf+S6Q0HhZqogKtGPXVTNABMUAOCGKx6fMyMjb/YLTcyRFU
   XH/Uw0Ah+iiGF5EcaCFuK68NjcFwIuKpqZ9UcZeiflW3Zi9otIRAFpp19
   W2a0HPU2LXcwZdu6Zx0oc9Kz2g4DMjFmcJU4Fe4gojnrxGvmLTMJF60/M
   KJXK525KcCec8LKoLPMDFVi04u4259HLM+IPUGDNmzSHr45kz+kUt98t8
   5mtw1jFTewm8KTu7nRk8NDd97aW+K8efc3iU5lmGGzMtYpbdpqgtusArS
   2IjWv+0qW2UjhWBgomFrn64WZWnLFyG4RPDir5G09PS/qCDcSLACBDWAQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="327566465"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="327566465"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 21:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="950132482"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="950132482"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2022 21:04:23 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1od1pW-0000aC-37;
	Tue, 27 Sep 2022 04:04:22 +0000
Date: Tue, 27 Sep 2022 12:03:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 5c2a64252c5dc4cfe78e5b2a531c118894e3d155
Message-ID: <63327624.9qJRjb/OrSLZ7k6G%lkp@intel.com>
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
branch HEAD: 5c2a64252c5dc4cfe78e5b2a531c118894e3d155  erofs: introduce partial-referenced pclusters

elapsed time: 724m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
mips                             allyesconfig
m68k                             allmodconfig
sh                               allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
i386                                defconfig
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
i386                             allyesconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20220926
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
arm64                            allyesconfig
i386                 randconfig-a006-20220926
arm                              allyesconfig
x86_64               randconfig-a002-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a001-20220926
x86_64               randconfig-a003-20220926
x86_64               randconfig-a006-20220926
arc                  randconfig-r043-20220925
s390                 randconfig-r044-20220925
riscv                randconfig-r042-20220925
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220926
riscv                randconfig-r042-20220926
hexagon              randconfig-r041-20220926
i386                 randconfig-a011-20220926
i386                 randconfig-a013-20220926
s390                 randconfig-r044-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
hexagon              randconfig-r041-20220925
hexagon              randconfig-r045-20220925
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a014-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
