Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C727F6685F3
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 22:49:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NtJ9l4MBLz3fTh
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jan 2023 08:49:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VsWlR4bS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VsWlR4bS;
	dkim-atps=neutral
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NtHvH4QQXz3gMx
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Jan 2023 08:37:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673559435; x=1705095435;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ubxtojzCJEGom/+i2suaEct6NvNj4B0zQzYd4IlXDMM=;
  b=VsWlR4bSgvNEMwVjzKI8Dsps5rauhP9uw5B2cjFlYgT7WQ9pQKvAQFtP
   MoSfYZEF04LD1NLA4PAT/dK/JBbgd/9L6xfb5vagEqkQ2D4XTgx+IGw21
   uoBOXWa11BwsNRWHR1JZn00bnc8JMIhuxfRb+PGJZUlJQs3N/6Qb5Sp2I
   f5srSAYrZlOuvLeEEHXh9dMyY0AawFlFgWMZeLMLL3zRloZEKneLFekCC
   dXSCagjco2WwfvAqjZnG28N3BkIY0qC7jcQw0r6yO/2u4FC74ZR8YaOZP
   FcVfbuLKrI8XLcKY+JKpm4TmgOxtTLrbhPZ+7hzicIOXdMggWDgXE8p6Y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="386181034"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="386181034"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 13:37:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="607951033"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="607951033"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Jan 2023 13:37:09 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pG5G0-000ARg-0U;
	Thu, 12 Jan 2023 21:37:08 +0000
Date: Fri, 13 Jan 2023 05:36:09 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 35626ac92db0300691a60c8061da2146c0943ba3
Message-ID: <63c07d49./lBWSAOmmlJT3VgM%lkp@intel.com>
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
branch HEAD: 35626ac92db0300691a60c8061da2146c0943ba3  erofs: clean up parsing of fscache related options

elapsed time: 725m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20230110
s390                 randconfig-r044-20230110
riscv                randconfig-r042-20230110
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
s390                                defconfig
x86_64                            allnoconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
um                           x86_64_defconfig
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
um                             i386_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
sh                               allmodconfig
arm                                 defconfig
x86_64                              defconfig
i386                                defconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a006
i386                             allyesconfig
riscv                             allnoconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                               rhel-8.3
arm                      integrator_defconfig
sh                           se7721_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
m68k                       bvme6000_defconfig
x86_64                           allyesconfig
riscv                randconfig-r042-20230112
s390                 randconfig-r044-20230112
arc                  randconfig-r043-20230112
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec

clang tested configs:
hexagon              randconfig-r041-20230110
arm                  randconfig-r046-20230110
hexagon              randconfig-r045-20230110
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                          g5_defconfig
mips                          malta_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
