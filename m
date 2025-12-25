Return-Path: <linux-erofs+bounces-1604-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB578CDD489
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Dec 2025 05:09:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcFd0487Qz2yG5;
	Thu, 25 Dec 2025 15:09:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766635780;
	cv=none; b=mqlQxCgZzgwodj6lzzZFyBLbycLvw/J0BVmvCWS1irlQZxTw3WcA94729WCUsoK2yjYw1vpvOTKnhQraPgynLUc7aLLbT4KVKZ/5Bh8eG/q/7+Hu7Pq3B5px9tpJuAf9Ea91RZ9Lyujy4V3pgScyR5p94IFbLTUqNPg+OJ5WJfkHktIe905GD/zOLxC1ewoATs+p5C0GJRQ2bK677POldY6IKuUBxp9/hsH6SccL/UQbrzqO+iVIkq6i312VONwxFhL3Fz/T0xofXVs3CAg8Y4d+lgFnVZtLIGycFf695Qe6xswwjYH8VqEBEtQ82E4j0+GoWEg3/KBVYJ/5NElxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766635780; c=relaxed/relaxed;
	bh=E/FVGKnOuOlFutlk020B8jyaJBPqEw2EBwBHZceXm+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/fDBV5CvMCYgcZgy2wc7s7/ZXQ3E5lPv/lmCo+4vjeW6gIJViBzcqIR+OPEs5S8/k7DbDIku9qLe+Qb5PqSjTdmswAsqUQOKGx61gRJfTn+NdB8SF2EQDjuFVXXcCKK0hpUeJXSEP3l7T+qCGh80lyAA+NB6MNgOkb7q/jE5YYkTQjD1i8PozzbI3H8Sp22nm8xRAK2fqoTCJM/bmtAnOm8sveFnf9NAcSNmJNV4qul1srMCq/7KFfVQTKBsZs8r8SF/XxuMf4qtWZ83p6RLidmHl9UFb+yneqETDHa3G4w9As0MNQiJnqsSQEwejRCNTJyLW5Dh81bLfmLqgPvLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c083g5q/; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c083g5q/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcFcy1FZbz2xrL
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 15:09:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766635778; x=1798171778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=usci4oWgBXO6Khv7C0L0mAXCj79IKm97m8nFeRZ4CsE=;
  b=c083g5q/NbK0XU5+wtZOmM3Q4FZqwSnv+/a0frqf0KAKPpNLeOXvpsZl
   N2c1Fk+2o/79LtWX3x5Am840DFs5Vf7Apb46Kb0I58xCAweP1vU4K5eaN
   6TXGsNogxmNLqpdYnofJQrQtQYVMeGvwN518e02Tw+a0pglC3WbbUenSh
   9XVqUFY6gwQU5kVXgHBaKgRO/sF2W0wVe8/RanAkpKKMJuhQ6IpFkAgaN
   CfqD3WTo+p0HG9P5vM9Az/zFnEylxjUrPGZ4M4MTP2kYBvA66EpSe5XFv
   OYlkjo24Ek1HqJNWN5qOkernjvN2QL+UK77WsHT51yeXqrmzsXdTps3bu
   g==;
X-CSE-ConnectionGUID: fZ9iGmhiRSK02DRUnKkPVg==
X-CSE-MsgGUID: Y8GNuiwMQvqo83A3b4sdHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="78758167"
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="78758167"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2025 20:09:32 -0800
X-CSE-ConnectionGUID: f9VP/PgWTvCURk+tklKXXA==
X-CSE-MsgGUID: q/L62GGxS060Bx2vW0qdKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="200634034"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 24 Dec 2025 20:09:28 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYcfG-000000003il-2377;
	Thu, 25 Dec 2025 04:09:26 +0000
Date: Thu, 25 Dec 2025 12:08:44 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, hsiangkao@linux.alibaba.com,
	chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
	amir73il@gmail.com, hch@lst.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH v11 05/10] erofs: support user-defined fingerprint name
Message-ID: <202512251143.WPBiiQZA-lkp@intel.com>
References: <20251224040932.496478-6-lihongbo22@huawei.com>
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
In-Reply-To: <20251224040932.496478-6-lihongbo22@huawei.com>
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes brauner-vfs/vfs.all linus/master v6.19-rc2 next-20251219]
[cannot apply to mszeredi-fuse/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/iomap-stash-iomap-read-ctx-in-the-private-field-of-iomap_iter/20251224-122950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20251224040932.496478-6-lihongbo22%40huawei.com
patch subject: [PATCH v11 05/10] erofs: support user-defined fingerprint name
config: powerpc-randconfig-001-20251225 (https://download.01.org/0day-ci/archive/20251225/202512251143.WPBiiQZA-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 4ef602d446057dabf5f61fb221669ecbeda49279)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251225/202512251143.WPBiiQZA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512251143.WPBiiQZA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/erofs/super.c:302:8: error: no member named 'ishare_xattr_pfx' in 'struct erofs_sb_info'
     302 |                 sbi->ishare_xattr_pfx =
         |                 ~~~  ^
   1 error generated.


vim +302 fs/erofs/super.c

   263	
   264	static int erofs_read_superblock(struct super_block *sb)
   265	{
   266		struct erofs_sb_info *sbi = EROFS_SB(sb);
   267		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
   268		struct erofs_super_block *dsb;
   269		void *data;
   270		int ret;
   271	
   272		data = erofs_read_metabuf(&buf, sb, 0, false);
   273		if (IS_ERR(data)) {
   274			erofs_err(sb, "cannot read erofs superblock");
   275			return PTR_ERR(data);
   276		}
   277	
   278		dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
   279		ret = -EINVAL;
   280		if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
   281			erofs_err(sb, "cannot find valid erofs superblock");
   282			goto out;
   283		}
   284	
   285		sbi->blkszbits = dsb->blkszbits;
   286		if (sbi->blkszbits < 9 || sbi->blkszbits > PAGE_SHIFT) {
   287			erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
   288			goto out;
   289		}
   290		if (dsb->dirblkbits) {
   291			erofs_err(sb, "dirblkbits %u isn't supported", dsb->dirblkbits);
   292			goto out;
   293		}
   294	
   295		sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
   296		if (erofs_sb_has_sb_chksum(sbi)) {
   297			ret = erofs_superblock_csum_verify(sb, data);
   298			if (ret)
   299				goto out;
   300		}
   301		if (erofs_sb_has_ishare_xattrs(sbi))
 > 302			sbi->ishare_xattr_pfx =
   303				dsb->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;
   304	
   305		ret = -EINVAL;
   306		sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
   307		if (sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT) {
   308			erofs_err(sb, "unidentified incompatible feature %x, please upgrade kernel",
   309				  sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT);
   310			goto out;
   311		}
   312	
   313		sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
   314		if (sbi->sb_size > PAGE_SIZE - EROFS_SUPER_OFFSET) {
   315			erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
   316				  sbi->sb_size);
   317			goto out;
   318		}
   319		sbi->dif0.blocks = le32_to_cpu(dsb->blocks_lo);
   320		sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
   321	#ifdef CONFIG_EROFS_FS_XATTR
   322		sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
   323		sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
   324		sbi->xattr_prefix_count = dsb->xattr_prefix_count;
   325		sbi->xattr_filter_reserved = dsb->xattr_filter_reserved;
   326	#endif
   327		sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
   328		if (erofs_sb_has_48bit(sbi) && dsb->rootnid_8b) {
   329			sbi->root_nid = le64_to_cpu(dsb->rootnid_8b);
   330			sbi->dif0.blocks = sbi->dif0.blocks |
   331					((u64)le16_to_cpu(dsb->rb.blocks_hi) << 32);
   332		} else {
   333			sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
   334		}
   335		sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
   336		if (erofs_sb_has_metabox(sbi)) {
   337			if (sbi->sb_size <= offsetof(struct erofs_super_block,
   338						     metabox_nid))
   339				return -EFSCORRUPTED;
   340			sbi->metabox_nid = le64_to_cpu(dsb->metabox_nid);
   341			if (sbi->metabox_nid & BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
   342				return -EFSCORRUPTED;	/* self-loop detection */
   343		}
   344		sbi->inos = le64_to_cpu(dsb->inos);
   345	
   346		sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
   347		sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
   348		super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
   349	
   350		if (dsb->volume_name[0]) {
   351			sbi->volume_name = kstrndup(dsb->volume_name,
   352						    sizeof(dsb->volume_name), GFP_KERNEL);
   353			if (!sbi->volume_name)
   354				return -ENOMEM;
   355		}
   356	
   357		/* parse on-disk compression configurations */
   358		ret = z_erofs_parse_cfgs(sb, dsb);
   359		if (ret < 0)
   360			goto out;
   361	
   362		ret = erofs_scan_devices(sb, dsb);
   363	
   364		if (erofs_sb_has_48bit(sbi))
   365			erofs_info(sb, "EXPERIMENTAL 48-bit layout support in use. Use at your own risk!");
   366		if (erofs_sb_has_metabox(sbi))
   367			erofs_info(sb, "EXPERIMENTAL metadata compression support in use. Use at your own risk!");
   368		if (erofs_is_fscache_mode(sb))
   369			erofs_info(sb, "[deprecated] fscache-based on-demand read feature in use. Use at your own risk!");
   370	out:
   371		erofs_put_metabuf(&buf);
   372		return ret;
   373	}
   374	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

