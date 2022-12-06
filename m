Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C531C643C48
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 05:33:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NR6wV6HPkz3bY0
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 15:32:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pokj1BZt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pokj1BZt;
	dkim-atps=neutral
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NR6wN601dz2y34
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Dec 2022 15:32:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670301173; x=1701837173;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BgsK/GlPLJwXzwOT0nN5kEcU34V0flly7/WYhFsD+0A=;
  b=Pokj1BZtKrwms38IYQudbwrHN5M6BFPWuisuh1aWX/IX0Tb0AWug37k3
   HqfX6c/3VvPBO4kWI+VMBmlsbso369RZb+QCYgkJ8KOOAf03oProlJxcb
   3Z4tgJ4a1UqIhImLLVisQkDequsd17sAFpM6TBPsGpRa5JZzruknXI4sP
   GfcqpA/pTOqkn1gJ+VV8USv8torYAxIRjpnHkncRBWKuctZl2zf0LO1rq
   iXWUca6lpFVyS53SyE6vGOWxiQOfKLmzftkEpKhAQM6HUNcJ1qxiOrHeF
   wgKO/UQfPdunS0XnBf7oPrwxXgSqG9El05qu/8P765aervxxIKhotwvNV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="296223118"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="296223118"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="676839740"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="676839740"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2022 20:32:41 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p2PdI-0000aQ-34;
	Tue, 06 Dec 2022 04:32:40 +0000
Date: Tue, 06 Dec 2022 12:32:35 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 a391c2a69c94ba32cb084bb0c6d41d955a67b8c3
Message-ID: <638ec5e3.B3kL0R91qfopHR9y%lkp@intel.com>
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
branch HEAD: a391c2a69c94ba32cb084bb0c6d41d955a67b8c3  erofs: validate the extent length for uncompressed pclusters

elapsed time: 730m

configs tested: 68
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
arc                                 defconfig
alpha                               defconfig
i386                                defconfig
alpha                            allyesconfig
arc                              allyesconfig
s390                                defconfig
ia64                             allmodconfig
um                             i386_defconfig
s390                             allmodconfig
m68k                             allyesconfig
um                           x86_64_defconfig
m68k                             allmodconfig
x86_64                              defconfig
arc                  randconfig-r043-20221205
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
s390                 randconfig-r044-20221205
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20221205
s390                             allyesconfig
powerpc                           allnoconfig
i386                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                 randconfig-a014-20221205
i386                 randconfig-a016-20221205
i386                 randconfig-a013-20221205
i386                 randconfig-a012-20221205
i386                 randconfig-a011-20221205
i386                 randconfig-a015-20221205
arm                                 defconfig
x86_64               randconfig-a015-20221205
x86_64               randconfig-a016-20221205
x86_64               randconfig-a011-20221205
x86_64               randconfig-a013-20221205
x86_64               randconfig-a012-20221205
x86_64               randconfig-a014-20221205
arm                              allyesconfig
arm64                            allyesconfig
x86_64                            allnoconfig

clang tested configs:
x86_64               randconfig-a003-20221205
x86_64               randconfig-a001-20221205
x86_64               randconfig-a002-20221205
hexagon              randconfig-r045-20221205
arm                  randconfig-r046-20221205
hexagon              randconfig-r041-20221205
x86_64               randconfig-a004-20221205
x86_64               randconfig-a006-20221205
x86_64               randconfig-a005-20221205
i386                 randconfig-a001-20221205
i386                 randconfig-a004-20221205
i386                 randconfig-a005-20221205
i386                 randconfig-a002-20221205
i386                 randconfig-a003-20221205
i386                 randconfig-a006-20221205
hexagon              randconfig-r041-20221204
riscv                randconfig-r042-20221204
hexagon              randconfig-r045-20221204
s390                 randconfig-r044-20221204

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
