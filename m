Return-Path: <linux-erofs+bounces-1523-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00370CD29EA
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Dec 2025 08:43:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYGcV33WDz2y6G;
	Sat, 20 Dec 2025 18:43:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766216634;
	cv=none; b=HyggYQ344+vR8KK1v8xa8nkXvgK/M6GuUDjd+cJMmtZc/YNWQLNFSvG36pNYfIx0DhqKqnAeMc1ruc5O5iF59kkH+tyzvvXzr5pbL608DR5eQuAzKemUPRE9j/QdKeBwkzJLeoM7mRU/Kf8u4h6BkdziW+nrkHoAiYFq6ZNtsY3lLtZFq/KtDoEDOJTR9VPG89XBxZXoes73c4uxpvaX319HJ/fTOYYRn7UpWrCr2730uQnhX1c+tzrBlgzR/IEQk8OTupzGoLOS0yR6zwRD/cwOu4VAPIFF0QgbT0DdO6ckgkOjWLFF5F2tp+56p2Nwwbldp7/ColbObl7Iu3fJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766216634; c=relaxed/relaxed;
	bh=+RgEuPCB5+/pfWtxKdufnhMnEz8pWLpCmc2pHPWaddA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Tg5vVLjRtnWd8bB+vEDfCz0QBu3Fz0jUQ0RHrvChHAPkz9fvzY/QhhV6vKz2ld56r0aDp3eQQdTjAlMQtuwoZm2H3tyx8oPaPzf/Vvrh/7q6lJmvn5+o34UQgNmkBi/vu7dtw+///Wm8f9CcNuOAIqNNJQIiZl7qwZA0LRdtrSSTsLqO00C3kKp1eHixhCu34XBoWQKBVjVvWGbMvD7JS/XB+uOADntqf2wFuAGj0IRMQV8tKSRjeBvmqPEWWI99ImtURba9I2sdKg+0ehJY2weuTgYfTIRYD5j7Tc6PtW/KI5Dz1/cxnxCFYt2DpOX17PwTyqsHIR8wowsUI+I8Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JdUj/Gk2; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JdUj/Gk2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dYGcR12GYz2xc8
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Dec 2025 18:43:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766216631; x=1797752631;
  h=date:from:to:cc:subject:message-id;
  bh=1NDSAFhSdxDRqCIpHRyispy6oGof5umabD+4KVy/L+I=;
  b=JdUj/Gk2FeHaop8hnNscQfL2bs0D0UqZCA1DfR4zHH4azMkDZqd1UgLa
   qgS9zg9wWMCPIBXJfyjwTT/xLNelupVTBaq+vjtATiq0Og4fIxoyfeGLa
   QGfcBsZKA1C9UUU6w4LeLTvvONjmKde0h863x/VE7gNTsBeWlGAO6pnT5
   quxfe9lWZU/puQJvWDhauMk0XzwOkP3tDoTe5X2AOJF2npCeB/7RLZ62d
   l9suKtd0YhwEGzyKHO9QKcSQSID1+M5g61cHL388dhB0rwkLgjoOC+zDV
   arHo2uMz/sQCpj9d+0Q5ti4Frd09SHKd+OTC3/MuqNH2G39NwCu4JWVmn
   Q==;
X-CSE-ConnectionGUID: PnurHOiETPCMVLxDJaRQqw==
X-CSE-MsgGUID: 6r+/6sOzTlK/z8fKdbCnwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68211665"
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="68211665"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 23:43:46 -0800
X-CSE-ConnectionGUID: fUvutz5CTc6L10YnyX2vCw==
X-CSE-MsgGUID: 2c3RbUwWT0yVKs/mWuHryA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="198314245"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 19 Dec 2025 23:43:45 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWrcs-000000004P1-0YmO;
	Sat, 20 Dec 2025 07:43:42 +0000
Date: Sat, 20 Dec 2025 15:42:56 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 5da7eab185b4386ce6a909a946fe28c134350253
Message-ID: <202512201542.p7Po4w6x-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 5da7eab185b4386ce6a909a946fe28c134350253  erofs: improve LZ4 error strings

elapsed time: 1474m

configs tested: 46
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha          allnoconfig    gcc-15.1.0
alpha         allyesconfig    gcc-15.1.0
arc            allnoconfig    gcc-15.1.0
arc           allyesconfig    clang-22
arm            allnoconfig    gcc-15.1.0
arm64         allmodconfig    clang-22
arm64          allnoconfig    gcc-15.1.0
csky          allmodconfig    gcc-15.1.0
csky           allnoconfig    gcc-15.1.0
hexagon       allmodconfig    gcc-15.1.0
hexagon        allnoconfig    gcc-15.1.0
i386          allmodconfig    clang-20
i386           allnoconfig    gcc-15.1.0
i386          allyesconfig    clang-20
loongarch     allmodconfig    clang-22
loongarch      allnoconfig    gcc-15.1.0
m68k          allmodconfig    gcc-15.1.0
m68k           allnoconfig    gcc-15.1.0
microblaze     allnoconfig    gcc-15.1.0
microblaze    allyesconfig    gcc-15.1.0
mips           allnoconfig    gcc-15.1.0
mips          allyesconfig    gcc-15.1.0
nios2         allmodconfig    clang-22
nios2          allnoconfig    clang-22
openrisc      allmodconfig    clang-22
openrisc       allnoconfig    clang-22
parisc         allnoconfig    clang-22
powerpc        allnoconfig    clang-22
riscv         allmodconfig    clang-22
riscv          allnoconfig    clang-22
s390           allnoconfig    clang-22
sh            allmodconfig    gcc-15.1.0
sh             allnoconfig    clang-22
sparc          allnoconfig    clang-22
sparc64       allmodconfig    clang-22
um             allnoconfig    clang-22
um            allyesconfig    gcc-15.1.0
x86_64        allmodconfig    clang-20
x86_64         allnoconfig    clang-22
x86_64        allyesconfig    clang-20
x86_64        rhel-9.4-bpf    gcc-14
x86_64      rhel-9.4-kunit    gcc-14
x86_64        rhel-9.4-ltp    gcc-14
x86_64       rhel-9.4-rust    clang-20
xtensa         allnoconfig    clang-22
xtensa        allyesconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

