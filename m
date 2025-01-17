Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6118AA1584F
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 20:45:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZVZn32pkz3cmC
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Jan 2025 06:45:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737143135;
	cv=none; b=MIpGl8z2M4roLDgALjOHg7RMZEFwVpB/dCGHJ2M2CfB+7ms15YEz6PW/xbiaIiWn9bLls9ja2EGWIsJ3TXXjIQLUF19GJqCBxCncPPFvgueIqM9q1B5SMaEHUyAz/GAAVoFr4u4PsUqsniNM/gl26R0B0qwPE7GHFYC9Qo8ASZKs1v89js1EoaeLYJY60ovQE3nh3tQxvMzC6Uruis1Z/jZcO/HFWHufML5v9wRNO98hEiKDPYi0F6CR+RSvy2ww5DSxCtb+06ufggUVKopjRwu2quOLBV4T70asBr/S+bo54GPVy1A8FyAnMY1U1DlFfIJ7Vmdmb3TzRIFIisElPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737143135; c=relaxed/relaxed;
	bh=4HyMvq5dRa6lVQgkIoAEnZcmn8BwJNUB/ol65RZY5ck=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PLUyL56M9PicNUksA94+S4OKGPf+zL5KZMp8I1xDufbjowLACZAH1AbfMKlFpVTU1e0D9nrNNmmLDWxHcsSKoFoCYyUZej82nGVx/EwVdU3B/e71f/bTl9ePdJMg7qGWq7WXtI3gAg9LV89eP+djt/uO1R27aVkZsMUdCjANOtx2DLVAEMqrD63PW3f6ZHU0tyWpyOZa/L+9Lcjlu2+j8TGO/fjm2bI8XOh8MFf4jgvwVSJUM7ncRHE5ERWenA6Tz5wL4Sw/Qzlc9ZIuvnaP3TIw+gxGiUdOlnzPp7dWmzC/L3aCN4qeedwBpPuHArNG09zjTu7avLjO+VA6W2MpfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dhAevKm7; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dhAevKm7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZVZj2lzXz30WP
	for <linux-erofs@lists.ozlabs.org>; Sat, 18 Jan 2025 06:45:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737143134; x=1768679134;
  h=date:from:to:cc:subject:message-id;
  bh=MCO4l1OQBmwdc03LYjvonTmzyZ1yzGv4H0GEP+iQjNs=;
  b=dhAevKm7+RaGsBNK8HM8CFPL+jgWVpC2aWetQXeki9K+N3+9WeUfhvVK
   MphbhdRwbCwmiRjN0Gxx69DtepCU26iDatAzIAUbI/kuQgU1rb7AoOahq
   emmle0J1lJOJPG5BUgmBltKLMKDp5cgo6fNQ0SN3NQqGtlDzZ/q04uS3v
   R44sixsRwQUnmxV7fTkb17tovqwKMmgtTa0eFG8yG/T0R8wpmFV4jfiE2
   LawkKgqxgHmiJNX7hNuN8E3AQhmNmB9hBBsea/9SUV3eBbgw2OMmWqlwn
   PGm5bJh3KfyTcj1wyXZDYtT3it8IDUN6rfieiXWMD4hG78v84MqlkPkLD
   w==;
X-CSE-ConnectionGUID: EfhCG2osTu+IwHVUFKcNTQ==
X-CSE-MsgGUID: A9o3utksRt20ccjEFPyAww==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37610873"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="37610873"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 11:45:28 -0800
X-CSE-ConnectionGUID: T8kcb+QjRqyA3bj9F6rXJw==
X-CSE-MsgGUID: qhMcQ2HZShqMfK2D10nPTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110886700"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Jan 2025 11:45:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYsHU-000TeC-1q;
	Fri, 17 Jan 2025 19:45:24 +0000
Date: Sat, 18 Jan 2025 03:44:44 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 41fb0fabc40113769ce53ea85ffd1f4bc87ae03a
Message-ID: <202501180338.N9OuQNBM-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 41fb0fabc40113769ce53ea85ffd1f4bc87ae03a  erofs: return SHRINK_EMPTY if no objects to free

elapsed time: 1444m

configs tested: 79
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250117    gcc-13.2.0
arc                   randconfig-002-20250117    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250117    clang-18
arm                   randconfig-002-20250117    gcc-14.2.0
arm                   randconfig-003-20250117    gcc-14.2.0
arm                   randconfig-004-20250117    clang-16
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250117    gcc-14.2.0
arm64                 randconfig-002-20250117    clang-18
arm64                 randconfig-003-20250117    clang-20
arm64                 randconfig-004-20250117    gcc-14.2.0
csky                  randconfig-001-20250117    gcc-14.2.0
csky                  randconfig-002-20250117    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250117    clang-20
hexagon               randconfig-002-20250117    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250117    clang-19
i386        buildonly-randconfig-002-20250117    clang-19
i386        buildonly-randconfig-003-20250117    gcc-12
i386        buildonly-randconfig-004-20250117    gcc-12
i386        buildonly-randconfig-005-20250117    clang-19
i386        buildonly-randconfig-006-20250117    gcc-11
loongarch             randconfig-001-20250117    gcc-14.2.0
loongarch             randconfig-002-20250117    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250117    gcc-14.2.0
nios2                 randconfig-002-20250117    gcc-14.2.0
parisc                randconfig-001-20250117    gcc-14.2.0
parisc                randconfig-002-20250117    gcc-14.2.0
powerpc               randconfig-001-20250117    gcc-14.2.0
powerpc               randconfig-002-20250117    gcc-14.2.0
powerpc               randconfig-003-20250117    gcc-14.2.0
powerpc64             randconfig-001-20250117    clang-16
powerpc64             randconfig-002-20250117    clang-20
powerpc64             randconfig-003-20250117    gcc-14.2.0
riscv                 randconfig-001-20250117    gcc-14.2.0
riscv                 randconfig-002-20250117    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250117    gcc-14.2.0
s390                  randconfig-002-20250117    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250117    gcc-14.2.0
sh                    randconfig-002-20250117    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250117    gcc-14.2.0
sparc                 randconfig-002-20250117    gcc-14.2.0
sparc64               randconfig-001-20250117    gcc-14.2.0
sparc64               randconfig-002-20250117    gcc-14.2.0
um                               allmodconfig    clang-20
um                               allyesconfig    gcc-12
um                    randconfig-001-20250117    clang-20
um                    randconfig-002-20250117    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250117    gcc-12
x86_64      buildonly-randconfig-002-20250117    gcc-12
x86_64      buildonly-randconfig-003-20250117    gcc-12
x86_64      buildonly-randconfig-004-20250117    gcc-12
x86_64      buildonly-randconfig-005-20250117    gcc-12
x86_64      buildonly-randconfig-006-20250117    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250117    gcc-14.2.0
xtensa                randconfig-002-20250117    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
