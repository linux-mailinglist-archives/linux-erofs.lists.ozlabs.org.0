Return-Path: <linux-erofs+bounces-341-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C5ABB12C
	for <lists+linux-erofs@lfdr.de>; Sun, 18 May 2025 20:07:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b0pgC5QHjz2xpn;
	Mon, 19 May 2025 04:07:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747591623;
	cv=none; b=liZl1VcZhvWPceEzWe7tPcVqK5K1QwbexP79sr1IKHOO7oRMbW4aPZkWdtmeJ6DiywNmC2Hp+VLQc7gHRWR7UhuXe334EFSygps5QCTshYwZn2alat/kC0vtjG0xrn9O2yoEHwg7MBNFDWbLNhn8jYV1fT8ZqpYXBgngJzSfD2swOCNP83Ih0kmmslKgkk4g75SskM/fxfB2+OXoxRTJnkkFyEJh6TRbkkpxFWb403PDKnhI6BVWLygrO9p472jMBmOu9wMXvLsNBlnzSsWoDXbx2/WXHUeKG3iYz37Xpq2toRltlfFj76eSYyG3ByiuejrveCLcjImDifDzpyRz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747591623; c=relaxed/relaxed;
	bh=dbGMwysZU8LaipEdpyyfKTQxUZ/1HxbIy9hSnMZ3APs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BwYu5+qG34LIKWcmjY/J7ub5AzY2/sVCdedrBhD+zciEjACyDRd/uCeH7oxtX/1WvWGkuiTENp7p5ckkkwK8OlBoblL0rMYj6R6GRgwA77YfEWa3YYJwBZbBLMf4EKPLcHhsR+rWz4kVKR7UamIT7f/TGMNPL/f7Y9xH19LtMwFN+JDvcXnFomR2YkFsKvY9ax0jyqR4vBRWCmTBclpRuPYeT+xXvsGG7ba8hxT1NfcKNbX4tYw/45tRSKWXvZE4AaCkz8aEdExq0/yVTzOuYFKcVIPycgyaqmfDtSL1mAYh+0WdE6euADupLVjrx2eBfmhOo6XJcZeJLtHqUnYFvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DXBWSJl5; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DXBWSJl5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b0pg85k1Zz2xlL
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 May 2025 04:06:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747591622; x=1779127622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ttGQYBloj0CoC1/5y7KQia+rkjJ2ddx/y9RCzSACYjw=;
  b=DXBWSJl5bWrL+kCEwb7/uuyy5h/1JfhXMZqlALAaBCtWxs6PHJYHesa2
   81fytnxapBzCRFFw5xThFSSbRC79NRqCbYK5Twvx+ViaPSw/UYBrJMAbd
   eB7eZEf32FkHbQTCfdWRbBihYPWgJkZWdMF7x3fapMLeV8q5aXVpDewH/
   hRoqSIILfYDCHAbO8+IvF/gU49MVvb1YfsFgXAWrVXDVSMSiChRljKirI
   rE9kYWh66tZm6LGsnZMN0ZdHJxzoYEIW6/SXoEzAvltx/kjd2qrBnhBIh
   ThfvPHbrd1uwf1e627OTwidK6E0MEIMiQSfFWBBkwdyQ+UarNtKFezgmD
   w==;
X-CSE-ConnectionGUID: OHkqBalbSi+PnvPW9vBrUw==
X-CSE-MsgGUID: /EI6iN9PQxCKoSv/dCbFzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="53313033"
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="53313033"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 11:06:56 -0700
X-CSE-ConnectionGUID: KtMrLVZtQ7OEBDsyosuChQ==
X-CSE-MsgGUID: gJV9Pz4JQSG6ZcMEwg3VKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="139217654"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 May 2025 11:06:54 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGiPT-000Ky5-2v;
	Sun, 18 May 2025 18:06:51 +0000
Date: Mon, 19 May 2025 02:06:37 +0800
From: kernel test robot <lkp@intel.com>
To: Sheng Yong <shengyong1@xiaomi.com>
Cc: oe-kbuild-all@lists.linux.dev, Xiang Gao <xiang@kernel.org>,
	linux-erofs@lists.ozlabs.org, Wang Shuai <wangshuai12@xiaomi.com>
Subject: [xiang-erofs:dev-test 5/5] fs/erofs/super.c:659:22: error: no member
 named 'off' in 'struct erofs_device_info'
Message-ID: <202505190150.4HUHevyn-lkp@intel.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   7cd18799175c533c3f9b1c2b2cb6551e2a86c921
commit: 7cd18799175c533c3f9b1c2b2cb6551e2a86c921 [5/5] erofs: add 'fsoffset' mount option to specify filesystem offset
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20250519/202505190150.4HUHevyn-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250519/202505190150.4HUHevyn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505190150.4HUHevyn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/erofs/super.c:659:22: error: no member named 'off' in 'struct erofs_device_info'
     659 |                                        sbi->dif0.off, 1 << sbi->blkszbits);
         |                                        ~~~~~~~~~ ^
   include/linux/fs_context.h:239:52: note: expanded from macro 'invalfc'
     239 | #define invalfc(fc, fmt, ...) (errorfc(fc, fmt, ## __VA_ARGS__), -EINVAL)
         |                                                    ^~~~~~~~~~~
   include/linux/fs_context.h:227:65: note: expanded from macro 'errorfc'
     227 | #define errorfc(fc, fmt, ...) __plog((&(fc)->log), 'e', fmt, ## __VA_ARGS__)
         |                                                                 ^~~~~~~~~~~
   include/linux/fs_context.h:192:17: note: expanded from macro '__plog'
     192 |                                         l, fmt, ## __VA_ARGS__)
         |                                                    ^~~~~~~~~~~
   1 error generated.


vim +659 fs/erofs/super.c

   602	
   603	static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
   604	{
   605		struct inode *inode;
   606		struct erofs_sb_info *sbi = EROFS_SB(sb);
   607		int err;
   608	
   609		sb->s_magic = EROFS_SUPER_MAGIC;
   610		sb->s_flags |= SB_RDONLY | SB_NOATIME;
   611		sb->s_maxbytes = MAX_LFS_FILESIZE;
   612		sb->s_op = &erofs_sops;
   613	
   614		sbi->blkszbits = PAGE_SHIFT;
   615		if (!sb->s_bdev) {
   616			sb->s_blocksize = PAGE_SIZE;
   617			sb->s_blocksize_bits = PAGE_SHIFT;
   618	
   619			if (erofs_is_fscache_mode(sb)) {
   620				err = erofs_fscache_register_fs(sb);
   621				if (err)
   622					return err;
   623			}
   624			err = super_setup_bdi(sb);
   625			if (err)
   626				return err;
   627		} else {
   628			if (!sb_set_blocksize(sb, PAGE_SIZE)) {
   629				errorfc(fc, "failed to set initial blksize");
   630				return -EINVAL;
   631			}
   632	
   633			sbi->dif0.dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
   634					&sbi->dif0.dax_part_off, NULL, NULL);
   635		}
   636	
   637		err = erofs_read_superblock(sb);
   638		if (err)
   639			return err;
   640	
   641		if (sb->s_blocksize_bits != sbi->blkszbits) {
   642			if (erofs_is_fscache_mode(sb)) {
   643				errorfc(fc, "unsupported blksize for fscache mode");
   644				return -EINVAL;
   645			}
   646	
   647			if (erofs_is_fileio_mode(sbi)) {
   648				sb->s_blocksize = 1 << sbi->blkszbits;
   649				sb->s_blocksize_bits = sbi->blkszbits;
   650			} else if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
   651				errorfc(fc, "failed to set erofs blksize");
   652				return -EINVAL;
   653			}
   654		}
   655	
   656		if (sbi->dif0.fsoff) {
   657			if (sbi->dif0.fsoff & (sb->s_blocksize - 1))
   658				return invalfc(fc, "fsoffset %llu is not aligned to block size %u",
 > 659					       sbi->dif0.off, 1 << sbi->blkszbits);
   660			if (erofs_is_fscache_mode(sb))
   661				return invalfc(fc, "cannot use fsoffset in fscache mode");
   662		}
   663	
   664		if (test_opt(&sbi->opt, DAX_ALWAYS)) {
   665			if (!sbi->dif0.dax_dev) {
   666				errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
   667				clear_opt(&sbi->opt, DAX_ALWAYS);
   668			} else if (sbi->blkszbits != PAGE_SHIFT) {
   669				errorfc(fc, "unsupported blocksize for DAX");
   670				clear_opt(&sbi->opt, DAX_ALWAYS);
   671			}
   672		}
   673	
   674		sb->s_time_gran = 1;
   675		sb->s_xattr = erofs_xattr_handlers;
   676		sb->s_export_op = &erofs_export_ops;
   677	
   678		if (test_opt(&sbi->opt, POSIX_ACL))
   679			sb->s_flags |= SB_POSIXACL;
   680		else
   681			sb->s_flags &= ~SB_POSIXACL;
   682	
   683		err = z_erofs_init_super(sb);
   684		if (err)
   685			return err;
   686	
   687		if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
   688			inode = erofs_iget(sb, sbi->packed_nid);
   689			if (IS_ERR(inode))
   690				return PTR_ERR(inode);
   691			sbi->packed_inode = inode;
   692		}
   693	
   694		inode = erofs_iget(sb, sbi->root_nid);
   695		if (IS_ERR(inode))
   696			return PTR_ERR(inode);
   697	
   698		if (!S_ISDIR(inode->i_mode)) {
   699			erofs_err(sb, "rootino(nid %llu) is not a directory(i_mode %o)",
   700				  sbi->root_nid, inode->i_mode);
   701			iput(inode);
   702			return -EINVAL;
   703		}
   704		sb->s_root = d_make_root(inode);
   705		if (!sb->s_root)
   706			return -ENOMEM;
   707	
   708		erofs_shrinker_register(sb);
   709		err = erofs_xattr_prefixes_init(sb);
   710		if (err)
   711			return err;
   712	
   713		erofs_set_sysfs_name(sb);
   714		err = erofs_register_sysfs(sb);
   715		if (err)
   716			return err;
   717	
   718		erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
   719		return 0;
   720	}
   721	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

