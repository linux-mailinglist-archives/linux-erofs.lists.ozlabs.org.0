Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2FD649266
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Dec 2022 06:09:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NVCVN0TrGz3bgZ
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Dec 2022 16:09:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z9qkO7xz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z9qkO7xz;
	dkim-atps=neutral
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NVCV816qzz30hh
	for <linux-erofs@lists.ozlabs.org>; Sun, 11 Dec 2022 16:09:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670735360; x=1702271360;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YvhuK8bksgfu8zTcuNkJcCcvQ6+JIBnOrYPpn4+P1BI=;
  b=Z9qkO7xz+4hUtXyon5P7wRQBs/JW7bMCedt/aU3inTDVf8gFS+A6ew+I
   Rnuxp1mD7w5n9pkwnAPByaRHJZeXCDZiZoGLgzDOkmfk8YcxyY7CZFRgd
   Spdu8KYyN1QEtNXif8ukHj66TaCcteiM6MRCVmDmz1MhAGXpDDrwU5cFm
   Kse5rktON2/AdunrCcCfyz0MhKE+69lxgjNNgvgfJl/W8EkJproUewcXa
   rpsP458UGWeBbgcatTlvNNA6XG4Q5fDAWOhRs5yovRQ2puGc0IQUPfa1i
   in5IyjWrlAHz6OwNcebXmXADr7CSRrXO5pambcNP30LMMXnSVZ9Mnme+C
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="318822061"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="318822061"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 21:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="976677219"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="976677219"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Dec 2022 21:09:10 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p4EaL-0002rS-1j;
	Sun, 11 Dec 2022 05:09:09 +0000
Date: Sun, 11 Dec 2022 13:08:32 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 c505feba4c0d76084e56ec498ce819f02a7043ae
Message-ID: <639565d0.FEF91a38lLn3afo2%lkp@intel.com>
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
branch HEAD: c505feba4c0d76084e56ec498ce819f02a7043ae  erofs: validate the extent length for uncompressed pclusters

elapsed time: 725m

configs tested: 85
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a004
x86_64                            allnoconfig
x86_64                        randconfig-a002
i386                          randconfig-a014
i386                          randconfig-a005
ia64                             allmodconfig
i386                          randconfig-a012
arc                               allnoconfig
x86_64                        randconfig-a013
x86_64                          rhel-8.3-rust
powerpc                           allnoconfig
powerpc                          allmodconfig
alpha                             allnoconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a006
i386                              allnoconfig
arm                               allnoconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
mips                             allyesconfig
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
arc                                 defconfig
s390                             allmodconfig
arc                  randconfig-r043-20221211
alpha                               defconfig
s390                                defconfig
arm                  randconfig-r046-20221211
s390                             allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
arc                        nsim_700_defconfig
i386                                defconfig
ia64                            zx1_defconfig
arm                        realview_defconfig
powerpc                     tqm8555_defconfig
alpha                            alldefconfig
mips                    maltaup_xpa_defconfig
powerpc                     pq2fads_defconfig
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
mips                     decstation_defconfig
sh                           se7206_defconfig
riscv                             allnoconfig
m68k                            q40_defconfig
riscv                               defconfig

clang tested configs:
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a002
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20221211
hexagon              randconfig-r045-20221211
riscv                randconfig-r042-20221211
s390                 randconfig-r044-20221211
mips                  cavium_octeon_defconfig
powerpc                     kmeter1_defconfig
arm                          sp7021_defconfig
powerpc                      obs600_defconfig
arm                              alldefconfig
arm                                 defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
