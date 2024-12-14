Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E98B39F1C06
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 02:55:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y98SC4fBYz3bWd
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 12:55:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734141353;
	cv=none; b=NYFrPg3MvGqMLseR/C6NQWB0e9rRLC1kjTVqQlS+MKDvsnc1/W6NF2cREQkrmJid30ida2oUvW6nOatfU4om7nVnjfviIyEusHix1MLVylCcGtg3pWj2V1j86loMdS5ki85j+TZxY2MfqsMZ9ovCqf8WtAWUqlo7DDMuTiE+l0dP9itJha2JREd3lkdwBA5e90KgjnVt23dEQ9oOZW361SLb3zao+/NO2XYfqejFdUdfAjVDzoC87LDYOfEz1f+4VZ1Ow0OY9hpkpTExlcw2fQX7AK1dkbYlbliknQUWiGmiE+EKgbhFvkPAcdiai1uobcigAKvJwo11/1CqLN36ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734141353; c=relaxed/relaxed;
	bh=ss53TzwWtt7w/d2Em+YnuWqD2vjpcPH/s8PuAPz5jvE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CrDHyCPh665QWh/0jmXadSQzv7GgxFQU6o/d4AzKDPAjS6RyAQhLbVDpNyR/tImDOG0nPUsIkO0yUcVCDjq6x/ENTt/sLD8I111VuQgu2EdQc+gfD57h2avqKMMaJ0bxnayLmt8CA9JzdQEP4PWHPffc41A17djXPYVBL1AqRVmHN9XtAOJeAZ8a4MPdNdZ8nYu/o/rOS0aMe3TosbhJPuyGPv/MMdjXn7YLm/bjEFbwIPq9X3efsWNqyk0dQbrPzdi+Vz1OKrqVqmp74m5CUmPkapkwSDTu9bitDFLXP35LftL27TthedNGwb+G0UN6wBHM0oPa8CwsAgTGvY+c2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HeA3ebke; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HeA3ebke;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y98S83cKfz2yVG
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 12:55:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734141353; x=1765677353;
  h=date:from:to:cc:subject:message-id;
  bh=PymYJWTKrtlTLWcoFnvLEha+gix4946Fat2MU3/U2CQ=;
  b=HeA3ebkezxSV8YVxqy+WTfBTQbCGwkzjZ64TtEBNz+JUJoNVxGQNbIIa
   6DRERP13z2UpX9HYEP1wq2gGhFATQgSTy3aNUa19hoAApSj6vwCUDsD12
   10w0doI2IDXQ9QRJGe65tSlheBrL7IHRC392t45gAA2YWN6A1YAy0Iy6P
   QCOqUVOlGMqx6/uXAR61iF1txO4b3FrJfzf/actYpggqXs4r9mYJwJPkw
   cp+fHDU+ycwTDanVMEY+Mjc5ZrFE+T7YkkYDeGpr3QZ1HQdlgEVC7rQTm
   uSXGVfZMmQRJ+NFD334C6Q+YXEPcaOszmFaRFvlZlPxKYQuhwkov91lom
   A==;
X-CSE-ConnectionGUID: UBCy9eh7SkW4+r8ZeaYdrQ==
X-CSE-MsgGUID: KPSHl+0PTwioaR94moOJag==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34522646"
X-IronPort-AV: E=Sophos;i="6.12,233,1728975600"; 
   d="scan'208";a="34522646"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 17:55:45 -0800
X-CSE-ConnectionGUID: nWkZEgTMTIebmSzZ7lQgRQ==
X-CSE-MsgGUID: LtfNU0UqRduBK+8x3nevzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96550639"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Dec 2024 17:55:43 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMHNd-000Ccl-1e;
	Sat, 14 Dec 2024 01:55:41 +0000
Date: Sat, 14 Dec 2024 09:55:27 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 93b8ae78880f96ab4b53635a47d5c952333da362
Message-ID: <202412140921.CfRmgdAV-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
branch HEAD: 93b8ae78880f96ab4b53635a47d5c952333da362  erofs: use buffered I/O for file-backed mounts by default

elapsed time: 1456m

configs tested: 92
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241213    gcc-13.2.0
arc                   randconfig-002-20241213    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241213    clang-16
arm                   randconfig-002-20241213    clang-18
arm                   randconfig-003-20241213    gcc-14.2.0
arm                   randconfig-004-20241213    clang-18
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20241213    gcc-14.2.0
arm64                 randconfig-002-20241213    gcc-14.2.0
arm64                 randconfig-003-20241213    clang-18
arm64                 randconfig-004-20241213    gcc-14.2.0
csky                  randconfig-001-20241213    gcc-14.2.0
csky                  randconfig-002-20241213    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20241213    clang-20
hexagon               randconfig-002-20241213    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241213    clang-19
i386        buildonly-randconfig-002-20241213    gcc-12
i386        buildonly-randconfig-003-20241213    gcc-12
i386        buildonly-randconfig-004-20241213    clang-19
i386        buildonly-randconfig-005-20241213    gcc-12
i386        buildonly-randconfig-006-20241213    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20241213    gcc-14.2.0
loongarch             randconfig-002-20241213    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20241213    gcc-14.2.0
nios2                 randconfig-002-20241213    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241213    gcc-14.2.0
parisc                randconfig-002-20241213    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20241213    gcc-14.2.0
powerpc               randconfig-002-20241213    clang-20
powerpc               randconfig-003-20241213    gcc-14.2.0
powerpc64             randconfig-001-20241213    gcc-14.2.0
powerpc64             randconfig-002-20241213    gcc-14.2.0
powerpc64             randconfig-003-20241213    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241213    gcc-14.2.0
riscv                 randconfig-002-20241213    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241213    gcc-14.2.0
s390                  randconfig-002-20241213    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241213    gcc-14.2.0
sh                    randconfig-002-20241213    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20241213    gcc-14.2.0
sparc                 randconfig-002-20241213    gcc-14.2.0
sparc64               randconfig-001-20241213    gcc-14.2.0
sparc64               randconfig-002-20241213    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20241213    gcc-12
um                    randconfig-002-20241213    clang-16
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241213    gcc-12
x86_64      buildonly-randconfig-002-20241213    gcc-12
x86_64      buildonly-randconfig-003-20241213    gcc-12
x86_64      buildonly-randconfig-004-20241213    gcc-12
x86_64      buildonly-randconfig-005-20241213    gcc-12
x86_64      buildonly-randconfig-006-20241213    clang-19
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20241213    gcc-14.2.0
xtensa                randconfig-002-20241213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
