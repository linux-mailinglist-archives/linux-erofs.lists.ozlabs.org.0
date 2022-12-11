Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2897649265
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Dec 2022 06:09:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NVCVJ03Mkz3bZx
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Dec 2022 16:09:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fDc7DKcc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fDc7DKcc;
	dkim-atps=neutral
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NVCV76NmJz2xFx
	for <linux-erofs@lists.ozlabs.org>; Sun, 11 Dec 2022 16:09:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670735360; x=1702271360;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jmR9TeNEFeCkyBwd77LgN7MMJUB8hG8VoXLa0h0qxBQ=;
  b=fDc7DKccv92Ip7Yy3bExclk/jlQcDrxdWgZhUnI70knPEsaG4NVOtG1j
   rd8MwuEtFkEAL/c1xLxK4juWFvl0nnNQGJf85MHR+OYAhIKE0Q/jTpGYt
   v/DGnzUioxEfs833s1hEL9L08pmYRCt5xZFeQtJO+pFBhUbVmifcp3VS5
   zgo1X0FS9JittfuIhn+/r7MIsv5BFhJHQ7nJ83mSrFvrlAlTKpDEd8Zyq
   uXRv71H/bV+d+vy9jjKcHy3S5wl/BovWQ/8O/88DwVYGRwyjNuuv2//yC
   1+mkUJYt6Xsvc/oAZmJSjYJSAmknAKSf6C56Dl9veP01SHXAK7g3WN2Wh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="317696822"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="317696822"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 21:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="716430607"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="716430607"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Dec 2022 21:09:10 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p4EaL-0002rN-1b;
	Sun, 11 Dec 2022 05:09:09 +0000
Date: Sun, 11 Dec 2022 13:08:34 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 2b4353ee5ba521ac03444b1126556c100a30c389
Message-ID: <639565d2.XdO0wcapwHtY28mV%lkp@intel.com>
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
branch HEAD: 2b4353ee5ba521ac03444b1126556c100a30c389  erofs/zmap.c: Fix incorrect offset calculation

elapsed time: 725m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20221211
arm                  randconfig-r046-20221211
powerpc                           allnoconfig
x86_64                            allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
i386                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
x86_64                              defconfig
alpha                               defconfig
arm                                 defconfig
x86_64                          rhel-8.3-rust
i386                          randconfig-a014
i386                          randconfig-a001
i386                          randconfig-a012
x86_64                          rhel-8.3-func
ia64                             allmodconfig
i386                          randconfig-a016
sh                               allmodconfig
i386                          randconfig-a003
x86_64                        randconfig-a004
i386                          randconfig-a005
mips                             allyesconfig
x86_64                        randconfig-a002
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a013
i386                             allyesconfig
s390                             allmodconfig
arm64                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a011
arm                              allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                               rhel-8.3
arm                            zeus_defconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
arm                        oxnas_v6_defconfig
x86_64                         rhel-8.3-kunit
loongarch                        alldefconfig
x86_64                           allyesconfig
m68k                             allyesconfig
sh                           se7722_defconfig
sparc                       sparc64_defconfig
m68k                             allmodconfig
x86_64                        randconfig-a015
mips                           jazz_defconfig
arm                         at91_dt_defconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
openrisc                            defconfig
x86_64                           rhel-8.3-kvm
mips                     decstation_defconfig
sh                           se7206_defconfig
i386                          randconfig-c001
arc                         haps_hs_defconfig
xtensa                generic_kc705_defconfig
arm                             pxa_defconfig
riscv                             allnoconfig

clang tested configs:
hexagon              randconfig-r045-20221211
hexagon              randconfig-r041-20221211
riscv                randconfig-r042-20221211
s390                 randconfig-r044-20221211
i386                          randconfig-a013
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a005
arm                            mmp2_defconfig
mips                     loongson2k_defconfig
arm                          collie_defconfig
powerpc                      obs600_defconfig
arm                              alldefconfig
arm                     am200epdkit_defconfig
mips                     loongson1c_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
