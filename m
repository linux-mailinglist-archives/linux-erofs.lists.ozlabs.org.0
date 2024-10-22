Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB9D9A9616
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2024 04:15:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XXbP86MJWz2yYk
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2024 13:15:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729563323;
	cv=none; b=AzA1gUrbbPtp1yAICbH8EHOeE74k/84fY8nS0kqQ4Knik+EWmWahnX9DN5+3s5kf6mGuON84qFixrTjQ4Et3arMxxsedSkDlKl5Aq/vebdEux89UZ/6WIzWLyVuQhWz+VIO717DYXyUo0srSKbYsaU0hr15jqXQQD+bMJ7sweBHM5pHd8CE6Te08HZqTY8iLiBckt5FuGEJdBDa3WGEoDBnZjJbGq09jimTmT0P5GprLSXZMHoGTQux/C9POEJSimv0K+2uXXhPyCiin5wmSu5049XVXz0u+frfNhRFso+iZt+s8T8HuqqxgiM/QIPP+C5BOtNwms+g0MJQ9DfnqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729563323; c=relaxed/relaxed;
	bh=eGoeXyAhCjFE98rEH+H0MmLBA1Va54I4PN/sP8v1Vk4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FpFQuF2RJwIdOMWWyLGuufbmqaL5rUorqHboT/2JhTR77JRIehGNfyHxkLWkyzd7H8pv/S8+zvNDVvnOeb4eMuMEybRqKsU4W43vOOF+gF6u2p4HeIvBaYC76blV9X9lxwDPAiHSPDbUpcRJdMnbcD44DPJHVAl//il+s+uRK6rKO6Ool6/m3ZmJ+lQR9UIayprn6eg4oVbOMtt4b7PrTDEovM7mc73iEN+4yY70JkRpeAEjcmY0LelKdA1TAhJ/wjj61E67swGF+orjlQz1ZQw5OeDC/7ODxMBFXnj+owdEP6flpoHNzcH6s6XcpEeV7PpL9n0whJnS9u3KypcmLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BJE6VIzi; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BJE6VIzi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XXbP45cmVz2xrv
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Oct 2024 13:15:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729563322; x=1761099322;
  h=date:from:to:cc:subject:message-id;
  bh=wDaIQUJVTyEb4anv6JQsVZAmd5eJCIV0MOTBMSWfLlY=;
  b=BJE6VIziVd/0Ma9u2mESw3sCH66EVudyUMUkde9fhPSw8HhsLBcFGcqG
   qQ85c/BvBQYSE2VaqvhNlD07i79ZEffv3DpAUA2z6Z9Zxq1hukVBOrR/i
   ZYE4oGY2dAZD6rQJDA/FH8Al0/ZQpZY6S4w4apV8M50DI3aU0oLY3B9YY
   e7rz/6QL882DaUF0jrmgiA9fa2k+9DsMlDZY4vNuyQ+vqLj6wifZMiIR9
   iqHS8uWp/GmT6DdXgrE4HeB0/AUh8eYPtWzFXoMOtfnj4GXIRmcaZFfU7
   0sdd1kJ0yuH5kxbN0X0mtekWy9eBDDwuV5KOHmi5iwHCR83uWauubo2ff
   A==;
X-CSE-ConnectionGUID: iGM6SPLNQVau4JF/HWtCcQ==
X-CSE-MsgGUID: AMtJggobSk+Ls1Rg7YeuAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28846333"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28846333"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 19:15:09 -0700
X-CSE-ConnectionGUID: uHHJr/jrTk66oTWvmmnFvw==
X-CSE-MsgGUID: QTwdioZKQ4uMjbV1ProPTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79635850"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Oct 2024 19:15:07 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t34QK-000Sva-1N;
	Tue, 22 Oct 2024 02:15:04 +0000
Date: Tue, 22 Oct 2024 10:14:55 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 2f831c82ddc2b31359209953dfa7ce0f386b6fdb
Message-ID: <202410221047.HSQHc8ng-lkp@intel.com>
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
branch HEAD: 2f831c82ddc2b31359209953dfa7ce0f386b6fdb  erofs: sunset `struct erofs_workgroup`

elapsed time: 1161m

configs tested: 76
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
alpha           allyesconfig    clang-20
alpha              defconfig    gcc-14.1.0
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arc                defconfig    gcc-14.1.0
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm                defconfig    gcc-14.1.0
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
arm64              defconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
csky               defconfig    gcc-14.1.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.1.0
hexagon         allyesconfig    clang-20
hexagon            defconfig    gcc-14.1.0
i386            allmodconfig    clang-18
i386             allnoconfig    clang-18
i386            allyesconfig    clang-18
i386               defconfig    clang-18
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
loongarch          defconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
m68k               defconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
microblaze         defconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
nios2              defconfig    gcc-14.1.0
openrisc         allnoconfig    clang-20
openrisc        allyesconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.1.0
parisc           allnoconfig    clang-20
parisc          allyesconfig    gcc-14.1.0
parisc             defconfig    gcc-12
parisc64           defconfig    gcc-14.1.0
powerpc         allmodconfig    gcc-14.1.0
powerpc          allnoconfig    clang-20
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv           allyesconfig    gcc-14.1.0
riscv              defconfig    gcc-12
s390            allmodconfig    gcc-14.1.0
s390             allnoconfig    clang-20
s390            allyesconfig    gcc-14.1.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.1.0
sh               allnoconfig    gcc-14.1.0
sh              allyesconfig    gcc-14.1.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.1.0
sparc64            defconfig    gcc-12
um              allmodconfig    clang-20
um               allnoconfig    clang-20
um              allyesconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-18
x86_64          allyesconfig    clang-18
x86_64             defconfig    clang-18
x86_64                 kexec    clang-18
x86_64                 kexec    gcc-12
x86_64              rhel-8.3    gcc-12
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
