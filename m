Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D176B5E8D27
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Sep 2022 15:37:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MZVSx1HGKz3cC1
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Sep 2022 23:37:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b3IWnkZo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b3IWnkZo;
	dkim-atps=neutral
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MZVSn0Y46z3bbP
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Sep 2022 23:37:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664026665; x=1695562665;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=h5hTcadG8569UF2eMrRm1W4SOk/RzyhzXALG+XBkKyo=;
  b=b3IWnkZoMZoICHduFetZ+StZEjf1dhhCidqTTg3b9fnp2z5KdiED5N5l
   LVV96LJk6crPRxB2ExUmC2MpW3k9wXa1s55w0NwDv+9FdBvMFTffhV+gd
   SWmXV8WZM6rq2nrpWGtpTN4cfd8WKIBMJ4BzUXBne26cbbmcmC3wJ7spF
   tTIUTgfWxE//LqoUsAvLLdEG6hym49w3g7ehi6CDNe04rx1lfQ1CCi7az
   cbaufoW5gqszMiIrQu05blpMWkUVvIFdUCtVDuzGYhxP9zc0OQS3l7HSz
   NRMZybM7QW/73861jcTmTmGzcmyGxFUTw1kyqbarQ8pHnVKn0NXfwZinU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="281141990"
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="281141990"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 06:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="620530185"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Sep 2022 06:37:34 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oc5LZ-0006YY-1D;
	Sat, 24 Sep 2022 13:37:33 +0000
Date: Sat, 24 Sep 2022 21:36:39 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 fc3678232928bcffa18c861e94125e4ad0561727
Message-ID: <632f07e7.gam05oQhgXr8vroJ%lkp@intel.com>
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
branch HEAD: fc3678232928bcffa18c861e94125e4ad0561727  erofs: introduce partial-referenced pclusters

elapsed time: 1412m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                                defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arc                  randconfig-r043-20220923
riscv                randconfig-r042-20220923
s390                 randconfig-r044-20220923
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arm                                 defconfig
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                        randconfig-a002
i386                          randconfig-a001
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a005
x86_64                        randconfig-a004
i386                          randconfig-a016
arm                              allyesconfig
arm64                            allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220923
hexagon              randconfig-r045-20220923
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
