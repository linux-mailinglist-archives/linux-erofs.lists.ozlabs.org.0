Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F67679A9D
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Jan 2023 14:53:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P1T2N3NtHz3cB9
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Jan 2023 00:53:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g77GVhMJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g77GVhMJ;
	dkim-atps=neutral
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P1T2F20j9z3c3m
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Jan 2023 00:53:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674568389; x=1706104389;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XynxcTJL1DsVqQQTs6nPR3Q32glw0Rws5ObJGTFjojc=;
  b=g77GVhMJutIjbZqopcbkrq+Md01u40C3I5bbKNu+GnU9kqhMdZiHzqFC
   qxGjEanUwzX6cenFg3urFjERVmcYCOeT2XfZZPxbDyXBl1WIykyx7G8Pq
   ooRSnFFuq6Styv4kQ1ofDScOcH/KdnqMK4+V+HX9LucU/KO42m0RFazhX
   Yl4QICoB8Ys1lsFyWSbllxlblDmEn9ISPLUTIqpRPs6JIP9YYYki84q21
   PZ2+YG7OaPCJDo+5ZlQbJmXD/4sHSyBNBHRIDDWRKs9QoYmnzm2SQzqUr
   HnKQG0bxq4cP1RFFVaIQKlZUZEMCM9K1bCIbMWxaOnMPOP37vTU081Uj0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390800010"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="390800010"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 05:52:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="664076100"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="664076100"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2023 05:52:57 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pKJjN-0006WG-0y;
	Tue, 24 Jan 2023 13:52:57 +0000
Date: Tue, 24 Jan 2023 21:52:04 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 e809f631b128a8cfd0834f47bc76b64f3f6be0a3
Message-ID: <63cfe284.UffhY2U/R3XgVnCP%lkp@intel.com>
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
branch HEAD: e809f631b128a8cfd0834f47bc76b64f3f6be0a3  erofs: simplify iloc()

elapsed time: 724m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
mips                             allyesconfig
s390                             allyesconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
i386                                defconfig
i386                 randconfig-a004-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a001-20230123
i386                             allyesconfig
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
arc                  randconfig-r043-20230123
x86_64                              defconfig
arm                  randconfig-r046-20230123
powerpc                          allmodconfig
arm                                 defconfig
x86_64                               rhel-8.3
x86_64               randconfig-a002-20230123
x86_64               randconfig-a001-20230123
x86_64               randconfig-a004-20230123
x86_64               randconfig-a003-20230123
x86_64               randconfig-a005-20230123
x86_64               randconfig-a006-20230123
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arm64                            allyesconfig
arm                              allyesconfig
x86_64                           allyesconfig
ia64                             allmodconfig
sh                   sh7724_generic_defconfig
powerpc                     rainier_defconfig
arm                         vf610m4_defconfig
mips                          rb532_defconfig
um                                  defconfig
sh                             espt_defconfig
sh                          rsk7201_defconfig
m68k                        m5407c3_defconfig
arm                            lart_defconfig
arm                             rpc_defconfig
s390                          debug_defconfig
arc                    vdk_hs38_smp_defconfig
openrisc                       virt_defconfig
i386                 randconfig-c001-20230123
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                         ps3_defconfig
powerpc                       eiger_defconfig
nios2                         10m50_defconfig
arm                          iop32x_defconfig
x86_64               randconfig-c001-20230123
arm                  randconfig-c002-20230123

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
i386                 randconfig-a012-20230123
s390                 randconfig-r044-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
riscv                randconfig-r042-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a015-20230123
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a014-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-k001-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
