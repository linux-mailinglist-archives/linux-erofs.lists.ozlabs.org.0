Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF31894E58
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 11:08:17 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+LM2aqu;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V829C0s1rz3dRm
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 20:08:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+LM2aqu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V82942tQkz3cZR
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 20:08:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712048888; x=1743584888;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ema+qLab8lL+nIbiX4CCF09DCqwE7Wm0HmljMxrRfiQ=;
  b=L+LM2aquVrxsT+MtVLw42blQvmW7reSXVblF81Oz2r1U6yuNONGB4EyK
   7j32xYPiAcRVlWbf5PqypZ1PDuClTPLD8d7PjF516nMRUwUaqgQb+ugTO
   gdeqayN2pGswjPvU4TahYeI6c+kgKVTWnrWHRE2l0XMcTaYzLb1gOPwZp
   W5G/QKZ3QiLNBgGCcTTK9TuvL2TVAkGPTBwXg4e8lhq6BQzrazKugGx5o
   lfcyYUujLbOyjs5/75nkov3GDqnG37NPiy2CeJR+NdTlKvoSaR3Xv+T7K
   /SQupaKcioO02L5PsvJXQqZQNtNJuCd4B0wkm+3hBb4dAYtsVqxi+UB6+
   Q==;
X-CSE-ConnectionGUID: Vd9KZ15eTPmnkza7yNt+Sg==
X-CSE-MsgGUID: Fwxw+VWtQ72FrKzGDSBnCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="11025465"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="11025465"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 02:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18052696"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 02 Apr 2024 02:07:59 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rra7W-00014m-0W;
	Tue, 02 Apr 2024 09:07:55 +0000
Date: Tue, 2 Apr 2024 17:07:04 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>
Subject: [xiang-erofs:dev-test 2/2] fs/erofs/super.c:876:6: error: assigning
 to 'int' from incompatible type 'void'
Message-ID: <202404021750.7EQaoKAb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: llvm@lists.linux.dev, linux-erofs@lists.ozlabs.org, oe-kbuild-all@lists.linux.dev
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   38654ff32711761d45ff138634e559a98003c31c
commit: 38654ff32711761d45ff138634e559a98003c31c [2/2] erofs: rename per-CPU buffers to global buffer pool and make it configurable
config: hexagon-randconfig-001-20240402 (https://download.01.org/0day-ci/archive/20240402/202404021750.7EQaoKAb-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240402/202404021750.7EQaoKAb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404021750.7EQaoKAb-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/erofs/super.c:10:
   In file included from include/linux/fs_context.h:14:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from fs/erofs/super.c:10:
   In file included from include/linux/fs_context.h:14:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from fs/erofs/super.c:10:
   In file included from include/linux/fs_context.h:14:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> fs/erofs/super.c:876:6: error: assigning to 'int' from incompatible type 'void'
           err = z_erofs_gbuf_init();
               ^ ~~~~~~~~~~~~~~~~~~~
   6 warnings and 1 error generated.


vim +876 fs/erofs/super.c

   850	
   851	static int __init erofs_module_init(void)
   852	{
   853		int err;
   854	
   855		erofs_check_ondisk_layout_definitions();
   856	
   857		erofs_inode_cachep = kmem_cache_create("erofs_inode",
   858				sizeof(struct erofs_inode), 0,
   859				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
   860				erofs_inode_init_once);
   861		if (!erofs_inode_cachep)
   862			return -ENOMEM;
   863	
   864		err = erofs_init_shrinker();
   865		if (err)
   866			goto shrinker_err;
   867	
   868		err = z_erofs_lzma_init();
   869		if (err)
   870			goto lzma_err;
   871	
   872		err = z_erofs_deflate_init();
   873		if (err)
   874			goto deflate_err;
   875	
 > 876		err = z_erofs_gbuf_init();
   877		if (err)
   878			goto gbuf_err;
   879	
   880		err = z_erofs_init_zip_subsystem();
   881		if (err)
   882			goto zip_err;
   883	
   884		err = erofs_init_sysfs();
   885		if (err)
   886			goto sysfs_err;
   887	
   888		err = register_filesystem(&erofs_fs_type);
   889		if (err)
   890			goto fs_err;
   891	
   892		return 0;
   893	
   894	fs_err:
   895		erofs_exit_sysfs();
   896	sysfs_err:
   897		z_erofs_exit_zip_subsystem();
   898	zip_err:
   899		z_erofs_gbuf_exit();
   900	gbuf_err:
   901		z_erofs_deflate_exit();
   902	deflate_err:
   903		z_erofs_lzma_exit();
   904	lzma_err:
   905		erofs_exit_shrinker();
   906	shrinker_err:
   907		kmem_cache_destroy(erofs_inode_cachep);
   908		return err;
   909	}
   910	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
