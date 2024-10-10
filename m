Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1D999529
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 00:24:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPkpD3Wzsz3bsn
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 09:24:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728599089;
	cv=none; b=Xvo3VyVXlIqw4TAw8oT+UyuDzZNQXdruVL82Qohw5b8kKCyWIJRsjmUoFJTDs97BfPArKAfsEVa9XO3xxrCV2lXAVhQFkTaBuRIjgeHclMt2ki5ieVNlaU8DApaPcvg/TQBJJrSEqYCm6zQFYZn+YsaOa5VxCqzCJ73bcl10WEfzaimwBwr8dvip3tWawgUqAmXkE7ovD01ulHwi9qP06ShjtyGEP3TDMQU5rSYDaYviZe0LOz/GecA+xj98ReyQ+pAkKw9mpoSAcK/hsj94RrsEBM7Lg+61sVR/W+FIGp+58jdWR2m8x/nttJ+VFFpYYvwWe4n5DsXsrkDYgP3OJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728599089; c=relaxed/relaxed;
	bh=GLOlhSoymk48DIQQitueShH24OW7wun0QPPePtiJxSE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N+bjsITUSk4udyUl+dguhxN+Ce6kf3cSwb5rlcwSnUFdzEWRSmM443KypFz9XJMOs+6TVwqD+D/+L3jdjIoUJnjW3tUhVDAmuzRSD1+4/6SI5/AmwPuM0Rl3PrMZuM8K16yuQ/Ux0aA34na2H9WvMlcqA3HYnF01YcWolWOINRTEmAY5np0hJpxpGtsoORQ7tvn3EbReVpDu9iB5z/xG/t7MIqUZLNcWkRVEKqpiXLxUx4hLl1xs9gYRLH1PgAimaio5tqscJajs2rN0fPOYtAzHIR9E2Wnj4msNQrI9HXrir+qPAMmuOg6/BVitf1jfCI+PzJNWTQg7nn+FycMlsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RzHAP83S; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RzHAP83S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPkp702qwz2yLT
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2024 09:24:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728599087; x=1760135087;
  h=date:from:to:cc:subject:message-id;
  bh=2oQEwHxMK0JdWkXK4wDKQ1RpcccIjeMmKl3DKx0ZX04=;
  b=RzHAP83SojDhrWM34M4bPADknhvPRm0hVE1+J+/0Flmj5BaqCwLb9B/t
   oAWjflgYrihUPYs3B7gUu42xJk5eSV5Ic5ye7rVgjg3Z2PHQNLj9wXilg
   Ew+aNHsMrzE+sIm+XVkd80jvV4AHebTCrdY9hXvSQutiAOHoIbjJXCUA6
   Y34/lBiC6402mycC9jhtoo2em7gT50J365C/o40Z7OJyJoCq04NYCp4iI
   IZZ+O5zgDEg6OaOg3kJy0CNBV2qeYDnj4LzA+lqugljzLkVcpeU2GJg7R
   N2kZA1h2GAN+mzpb6X3Dw8iRazBeN3A4LmSbPP4pgLnH8lHuTcwiNeSH3
   w==;
X-CSE-ConnectionGUID: Gk2aU5McTWeHgDpcq6SlMQ==
X-CSE-MsgGUID: 5Y/4B2+OR6GukY6KEpd05Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31782066"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="31782066"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 15:24:38 -0700
X-CSE-ConnectionGUID: +lo6XKlVSpCQYsITNz7DcA==
X-CSE-MsgGUID: QEiIFkEJQO2eVsAZctHRHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="76933371"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Oct 2024 15:24:38 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sz1aE-000BM9-2f;
	Thu, 10 Oct 2024 22:24:34 +0000
Date: Fri, 11 Oct 2024 06:24:04 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 56bd565ea59192bbc7d5bbcea155e861a20393f4
Message-ID: <202410110658.QyOAlZzJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
branch HEAD: 56bd565ea59192bbc7d5bbcea155e861a20393f4  erofs: get rid of kaddr in `struct z_erofs_maprecorder`

elapsed time: 737m

configs tested: 54
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-14.1.0
alpha        allyesconfig    clang-20
arc          allmodconfig    clang-20
arc           allnoconfig    gcc-14.1.0
arc          allyesconfig    clang-20
arm          allmodconfig    clang-20
arm           allnoconfig    gcc-14.1.0
arm          allyesconfig    clang-20
arm64        allmodconfig    clang-20
arm64         allnoconfig    gcc-14.1.0
csky          allnoconfig    gcc-14.1.0
hexagon      allmodconfig    clang-20
hexagon       allnoconfig    gcc-14.1.0
hexagon      allyesconfig    clang-20
i386         allmodconfig    clang-18
i386          allnoconfig    clang-18
i386         allyesconfig    clang-18
i386            defconfig    clang-18
loongarch    allmodconfig    gcc-14.1.0
loongarch     allnoconfig    gcc-14.1.0
m68k         allmodconfig    gcc-14.1.0
m68k          allnoconfig    gcc-14.1.0
m68k         allyesconfig    gcc-14.1.0
microblaze   allmodconfig    gcc-14.1.0
microblaze    allnoconfig    gcc-14.1.0
microblaze   allyesconfig    gcc-14.1.0
mips          allnoconfig    gcc-14.1.0
nios2         allnoconfig    gcc-14.1.0
openrisc      allnoconfig    clang-20
openrisc     allyesconfig    gcc-14.1.0
parisc       allmodconfig    gcc-14.1.0
parisc        allnoconfig    clang-20
parisc       allyesconfig    gcc-14.1.0
powerpc      allmodconfig    gcc-14.1.0
powerpc       allnoconfig    clang-20
powerpc      allyesconfig    gcc-14.1.0
riscv        allmodconfig    gcc-14.1.0
riscv         allnoconfig    clang-20
riscv        allyesconfig    gcc-14.1.0
s390         allmodconfig    gcc-14.1.0
s390          allnoconfig    clang-20
s390         allyesconfig    gcc-14.1.0
sh           allmodconfig    gcc-14.1.0
sh            allnoconfig    gcc-14.1.0
sh           allyesconfig    gcc-14.1.0
sparc        allmodconfig    gcc-14.1.0
um           allmodconfig    clang-20
um            allnoconfig    clang-20
um           allyesconfig    clang-20
x86_64        allnoconfig    clang-18
x86_64       allyesconfig    clang-18
x86_64          defconfig    clang-18
x86_64      rhel-8.3-rust    clang-18
xtensa        allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
