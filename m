Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8439365C241
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Jan 2023 15:50:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NmbHy1f37z3bgt
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 01:50:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hWFUqj3/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hWFUqj3/;
	dkim-atps=neutral
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NmbHp0fqpz2ybK
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 01:50:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672757415; x=1704293415;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rYByriY6B+t5GIfGfzOMb/UiWHPloGDqlku4XbImpqI=;
  b=hWFUqj3/A8hDa619MJZ/6Dt9hAwpEQ2wYNOPTUTJZewSeQDQh5ru+j9H
   3QmzyngkQ+6MUhyHMzo+17Frp8yclmdNNzKN5ASCMh6BvRrm2RK2THopE
   ZBD8LNZAxAZ/D5OoLJONq2svTSGttfif4a1Nnm8rnyknq/u5zrjLzm6LM
   bosaRzrt7pIY9XHQLl2P78/HH1CTpdyRXKyZfsK19KDtzPLuQbJlgneDW
   MRfBKPr7f6gbIY26uDGy3u75mBCFabbDYBsaZfQGybGd2SdKffX3WH9ys
   NUeNbWZHWI0JD1oVtAyJd6yNAXJyz6d6RiaotMKyLqNaaC/YzjhkR7Fx1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="319382384"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="319382384"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 06:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="723291102"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="723291102"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jan 2023 06:50:03 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pCic6-000SML-1m;
	Tue, 03 Jan 2023 14:50:02 +0000
Date: Tue, 03 Jan 2023 22:49:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 3ae2c449e4122fabf4da1c1392776255a0aa6e6e
Message-ID: <63b4408c.SLL7y1OaI+qjKfTw%lkp@intel.com>
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
branch HEAD: 3ae2c449e4122fabf4da1c1392776255a0aa6e6e  erofs/zmap.c: Fix incorrect offset calculation

elapsed time: 722m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
arc                                 defconfig
alpha                            allyesconfig
s390                             allmodconfig
mips                             allyesconfig
alpha                               defconfig
s390                                defconfig
arc                              allyesconfig
s390                             allyesconfig
arm                                 defconfig
i386                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arm64                            allyesconfig
x86_64                              defconfig
x86_64               randconfig-a004-20230102
i386                 randconfig-a004-20230102
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
x86_64                               rhel-8.3
arc                               allnoconfig
i386                 randconfig-a003-20230102
x86_64               randconfig-a006-20230102
x86_64               randconfig-a002-20230102
arm                              allyesconfig
x86_64                           rhel-8.3-bpf
i386                 randconfig-a006-20230102
riscv                randconfig-r042-20230101
x86_64               randconfig-a003-20230102
powerpc                          allmodconfig
i386                 randconfig-a001-20230102
x86_64                           allyesconfig
ia64                             allmodconfig
arc                  randconfig-r043-20230102
x86_64               randconfig-a005-20230102
s390                 randconfig-r044-20230101
x86_64                           rhel-8.3-syz
x86_64               randconfig-a001-20230102
i386                 randconfig-a002-20230102
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a005-20230102
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-kvm
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101
i386                             allyesconfig
x86_64                            allnoconfig
riscv                             allnoconfig

clang tested configs:
i386                 randconfig-a016-20230102
i386                 randconfig-a012-20230102
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a013-20230102
x86_64               randconfig-a011-20230102
i386                 randconfig-a015-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a013-20230102
hexagon              randconfig-r041-20230102
x86_64               randconfig-a015-20230102
s390                 randconfig-r044-20230102
arm                  randconfig-r046-20230101
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230102
x86_64               randconfig-a016-20230102
x86_64               randconfig-a014-20230102
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101
hexagon              randconfig-r045-20230101

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
