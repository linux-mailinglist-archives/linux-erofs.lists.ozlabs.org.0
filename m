Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43FD55BA7D
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Jun 2022 16:29:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LWqqF4mbgz3bry
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 00:29:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jBRTwUV9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jBRTwUV9;
	dkim-atps=neutral
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LWqq412w3z3bnr
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 00:28:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656340145; x=1687876145;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iNktxbbAjtz0fPOuMB5bgDoC6PKLVKSp0LhsrCNzzyg=;
  b=jBRTwUV9CWsU0RafxvxcFTrxP2TF9iYgR+GJC2dx6Usud7qxPLsH87m5
   3sc4CpbPAsOudCopXbL/6rt19XoQD5pEYfpwktbXUwgCSrjfDpPGjEzXg
   NWVI912tNXbsS9P7i55leXZbk8PW6uSH6NwMp2zm/k7rjRpwtDkDqg0/q
   1FRUR7yqGXs5o/iCjz9nXINC2vx2UylaQQLTO5iQ0Euj6E2mUdu0IvgHG
   7z7joMdtE/pWNYkJ9tvpIJJ5r8D8yA0IWTzZvlS1GtVQHmjeJccSQE7Di
   TNzenHnYvhDLuPpZ6kngfcmzslugL/X5KQATlHNd1eeE+56aKa/PnYbXI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="261265648"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="261265648"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 07:28:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="540121941"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2022 07:28:53 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o5pjQ-0008dz-Ed;
	Mon, 27 Jun 2022 14:28:52 +0000
Date: Mon, 27 Jun 2022 22:28:22 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 302f0e583267560d93a2d23d814ac323c7739e38
Message-ID: <62b9be86.lDRIngQ952PBEhEc%lkp@intel.com>
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
branch HEAD: 302f0e583267560d93a2d23d814ac323c7739e38  erofs: Wake up all waiters after z_erofs_lzma_head ready.

elapsed time: 724m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220627
m68k                       m5208evb_defconfig
sh                        sh7763rdp_defconfig
ia64                             alldefconfig
arm                        keystone_defconfig
sh                           se7343_defconfig
arm                       multi_v4t_defconfig
arm                         at91_dt_defconfig
arm                            mps2_defconfig
arm                        multi_v7_defconfig
powerpc                     tqm8541_defconfig
sh                        dreamcast_defconfig
arm                        shmobile_defconfig
powerpc                     mpc83xx_defconfig
sh                          sdk7786_defconfig
sh                               alldefconfig
powerpc                     ep8248e_defconfig
mips                             allyesconfig
sh                            migor_defconfig
ia64                                defconfig
powerpc                 mpc834x_mds_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64               randconfig-c001-20220627
arm                  randconfig-c002-20220627
ia64                             allmodconfig
x86_64               randconfig-k001-20220627
m68k                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
powerpc                          allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64               randconfig-a013-20220627
x86_64               randconfig-a012-20220627
x86_64               randconfig-a016-20220627
x86_64               randconfig-a015-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a014-20220627
i386                 randconfig-a016-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a013-20220627
i386                 randconfig-a014-20220627
arc                  randconfig-r043-20220626
arc                  randconfig-r043-20220627
riscv                randconfig-r042-20220627
s390                 randconfig-r044-20220627
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     kilauea_defconfig
powerpc                    gamecube_defconfig
powerpc                      obs600_defconfig
powerpc                       ebony_defconfig
arm                            dove_defconfig
x86_64               randconfig-a005-20220627
x86_64               randconfig-a004-20220627
x86_64               randconfig-a003-20220627
x86_64               randconfig-a006-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a002-20220627
i386                 randconfig-a001-20220627
i386                 randconfig-a002-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a005-20220627
i386                 randconfig-a006-20220627
i386                 randconfig-a004-20220627
hexagon              randconfig-r041-20220626
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220626
riscv                randconfig-r042-20220626
hexagon              randconfig-r045-20220627
s390                 randconfig-r044-20220626

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
