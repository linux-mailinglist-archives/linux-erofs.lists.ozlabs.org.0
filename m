Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC91A664E28
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 22:40:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ns43c3rbwz3bk8
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 08:40:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ArEcV3rz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ArEcV3rz;
	dkim-atps=neutral
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ns43T2L58z3bWF
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 08:39:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673386805; x=1704922805;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FnIlhWRN5hYPa9fPD6PUR2A8M458FqEjluUGDwPST+I=;
  b=ArEcV3rz+aN3j+vP6LRMqHv0NaSMQDtz//hjWySoBVkZDDHie+MF3xvE
   BjhlPYps0Rd9JH7xX/r1RQFbGGTH+twjyyFx8KgWqlX2exGgKsTIwhucN
   hdT71jm+VHM7PbePGFM8AQRUF7i2BwNU7Ei9qUgqak5gLZqcSG5psQnqT
   PCbDBlPWO4SsZNPgVIQJjfR7JmoC/96BMn5zr3+nG4beMLFrfq5IW6RLo
   Qrk9n1nyjvv6r5GbpCZHW4LPHOb3qf4uaT/HIB8RlJUFBhOyFcKImwfIK
   vNaNJlJbFkYBk4/GhBSXdnRZZSLDrAdPxbac/TyOhQJ/H/16FA12YlhDP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311069170"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="311069170"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 13:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="725681421"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="725681421"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jan 2023 13:39:51 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pFMLW-0008OF-1L;
	Tue, 10 Jan 2023 21:39:50 +0000
Date: Wed, 11 Jan 2023 05:38:50 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 12724ba38992bd045e92a9a88a868a530f89d13e
Message-ID: <63bddaea.4JA1ZCVNYKWYBS7N%lkp@intel.com>
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
branch HEAD: 12724ba38992bd045e92a9a88a868a530f89d13e  erofs: fix kvcalloc() misuse with __GFP_NOFAIL

elapsed time: 720m

configs tested: 104
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
i386                 randconfig-a012-20230109
i386                 randconfig-a014-20230109
i386                 randconfig-a016-20230109
i386                 randconfig-a015-20230109
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
s390                                defconfig
arm                                 defconfig
mips                             allyesconfig
x86_64               randconfig-a016-20230109
x86_64                              defconfig
powerpc                          allmodconfig
s390                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a006
ia64                             allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a003
x86_64               randconfig-a014-20230109
i386                          randconfig-a001
x86_64               randconfig-a011-20230109
x86_64               randconfig-a013-20230109
x86_64               randconfig-a012-20230109
x86_64               randconfig-a015-20230109
x86_64                          rhel-8.3-func
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-bpf
i386                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20230110
riscv                             allnoconfig
s390                 randconfig-r044-20230110
riscv                randconfig-r042-20230110
riscv                randconfig-r042-20230109
s390                 randconfig-r044-20230109
arm                  randconfig-r046-20230108
arc                  randconfig-r043-20230108
arc                  randconfig-r043-20230109
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                 randconfig-a004-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a001-20230109
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                 randconfig-a005-20230109
i386                 randconfig-a006-20230109
i386                          randconfig-a002
i386                          randconfig-a004
x86_64               randconfig-a003-20230109
x86_64                          rhel-8.3-rust
i386                          randconfig-a006
x86_64               randconfig-a002-20230109
x86_64               randconfig-a004-20230109
x86_64               randconfig-a005-20230109
x86_64               randconfig-a001-20230109
x86_64               randconfig-a006-20230109
hexagon              randconfig-r045-20230109
arm                  randconfig-r046-20230109
arm                  randconfig-r046-20230110
riscv                randconfig-r042-20230108
hexagon              randconfig-r041-20230108
hexagon              randconfig-r045-20230110
hexagon              randconfig-r041-20230109
hexagon              randconfig-r045-20230108
hexagon              randconfig-r041-20230110
s390                 randconfig-r044-20230108
riscv                          rv32_defconfig
powerpc                      ppc64e_defconfig
powerpc                      ppc44x_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
