Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DC02D3958
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 04:55:04 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrNVF3MBFzDqjb
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 14:55:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrNTz4lhXzDqhC
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 14:54:42 +1100 (AEDT)
IronPort-SDR: 1vvIA1DDst96kYZVDQ6sswWbtuTsRftyzX+0ZR2d/PbD0tR0iavD4XWYj1HBHymxCP7+hHWzUl
 p6tS7K8CXXlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="235613611"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; d="scan'208";a="235613611"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2020 19:54:38 -0800
IronPort-SDR: Zz9LfwAkmFy26wbwO6gXxsAAjuYcYa/ptT7aLgOZ6bymr9kpw8q3cW4QAEySyksrm4mvZMOM4I
 BG5h8pzwj2oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; d="scan'208";a="370657832"
Received: from lkp-server01.sh.intel.com (HELO 4e633a5ce5ea) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2020 19:54:36 -0800
Received: from kbuild by 4e633a5ce5ea with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kmqYm-000075-9C; Wed, 09 Dec 2020 03:54:36 +0000
Date: Wed, 09 Dec 2020 11:53:49 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 6890dbdfddf9dc50ca7f09dfa1022f0e92a613c8
Message-ID: <5fd04a4d.WFJuYeseSp2BUK6a%lkp@intel.com>
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
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git  dev-test
branch HEAD: 6890dbdfddf9dc50ca7f09dfa1022f0e92a613c8  erofs: force inplace I/O under low memory scenario

elapsed time: 725m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc64                           defconfig
powerpc                     pseries_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          rsk7264_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7724_defconfig
powerpc                     ep8248e_defconfig
arm                         assabet_defconfig
sh                           se7721_defconfig
arm                       omap2plus_defconfig
m68k                       m5475evb_defconfig
arm                             mxs_defconfig
powerpc                   currituck_defconfig
mips                         rt305x_defconfig
powerpc                     tqm8541_defconfig
c6x                        evmc6678_defconfig
powerpc                     tqm5200_defconfig
powerpc                      acadia_defconfig
arc                        nsimosci_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201208
x86_64               randconfig-a012-20201208
x86_64               randconfig-a013-20201208
x86_64               randconfig-a014-20201208
x86_64               randconfig-a015-20201208
x86_64               randconfig-a011-20201208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
