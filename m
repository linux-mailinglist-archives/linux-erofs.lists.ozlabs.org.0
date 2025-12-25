Return-Path: <linux-erofs+bounces-1605-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D118CDD62C
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Dec 2025 07:44:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcK312rWtz2xP9;
	Thu, 25 Dec 2025 17:43:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766645037;
	cv=none; b=BCYqUx2bKoQUW7VU5sTr2pI+kSTgG8sXJ3wyMgB0nMynM1XnrRVb7E13hHz0ZG7nhgYA9wi0JgLlThw4Jh+oMX//gyTordKX/XsVLMYX5e0yMRpTANXGCUhVeObHHzfvp15me3uocoyedzvZ9W/vJfydv1ZJhrqExeZkG3N53eWphcupPm+LLTOhCXgLhs0cF7L7024huxtpQwqDQbMM8aOWpstFFAZEJNL4kqNmfGXwve3PuJVSqSjG2uXZQRbVK3PfOs4LTCG/M3jEs4vxQm+mxJWpXD63EC52G9HmyuivRC9+c1YfY/iX6NISGys+d3gR4yF3B5PkfYl0wIZgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766645037; c=relaxed/relaxed;
	bh=wDVo5ZMuJJlTLCFSV3tOhYsS1hFv8OyliBSvsYitbIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K74CU9HDVw4KUs9A4Phi5N0Pjo+pR/QiEYs7DboXiAAoT/y75hsHovLsrXI6HXSkM5PfJCfeamukfj8dGhYrLPAa7gthfjNzxJ1PlKY6ZckLtYt6y2Q0/uJ/8fYp0U4HGXlzJK5iI5ph7NswwQa6qqbAjDNxC6Qj/MvWIYQH14uwrtTajAXiJPSQxmAvOyfZkgzbWcElzk1KpPdD+Guudc5GKaX+QZfS4COgoUmJPHZlz0NvoSZsVxOD/VV9HIw+GdEZcp1EoKrSxs9+zWCEP9dd4DuuIPlhanj7BcpYzGGiYQsJz2GCmpDCidurQmnSxyKOZnO9ZTBqR241RGVL4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TWtczkX6; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TWtczkX6; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TWtczkX6;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TWtczkX6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1171 seconds by postgrey-1.37 at boromir; Thu, 25 Dec 2025 17:43:53 AEDT
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcK2x6nzpz2xP8
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 17:43:50 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wDVo5ZMuJJlTLCFSV3tOhYsS1hFv8OyliBSvsYitbIY=;
	b=TWtczkX6q+OqvMpH7zdv0cfAtt7JFwo+hSJvWispJQcTSRIf4HTD9+gGllcZQa9+WiJrrYclB
	7eirHwplgMhMLTzvSCWcyqR5VZ9pIIc2MNSbYZWkPxhI9ZsVNuKefIfbgCnS1FhqVNiP7GoU4Ho
	8bwxTifn+UeDxYXT/HptIFM=
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dcJbY2kTYz1BFQ7
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 14:23:37 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wDVo5ZMuJJlTLCFSV3tOhYsS1hFv8OyliBSvsYitbIY=;
	b=TWtczkX6q+OqvMpH7zdv0cfAtt7JFwo+hSJvWispJQcTSRIf4HTD9+gGllcZQa9+WiJrrYclB
	7eirHwplgMhMLTzvSCWcyqR5VZ9pIIc2MNSbYZWkPxhI9ZsVNuKefIfbgCnS1FhqVNiP7GoU4Ho
	8bwxTifn+UeDxYXT/HptIFM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dcJXP56wrzRhSF;
	Thu, 25 Dec 2025 14:20:53 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E8214056C;
	Thu, 25 Dec 2025 14:24:01 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Dec 2025 14:24:00 +0800
Message-ID: <5014167f-3a45-44d3-9d84-7adbf9841651@huawei.com>
Date: Thu, 25 Dec 2025 14:24:00 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/10] erofs: support user-defined fingerprint name
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, <hsiangkao@linux.alibaba.com>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <hch@lst.de>, <amir73il@gmail.com>,
	<djwong@kernel.org>, <brauner@kernel.org>, <chao@kernel.org>
References: <20251224040932.496478-6-lihongbo22@huawei.com>
 <202512251143.WPBiiQZA-lkp@intel.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <202512251143.WPBiiQZA-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/25 12:08, kernel test robot wrote:
> Hi Hongbo,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on xiang-erofs/dev-test]
> [also build test ERROR on xiang-erofs/dev xiang-erofs/fixes brauner-vfs/vfs.all linus/master v6.19-rc2 next-20251219]
> [cannot apply to mszeredi-fuse/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/iomap-stash-iomap-read-ctx-in-the-private-field-of-iomap_iter/20251224-122950
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
> patch link:    https://lore.kernel.org/r/20251224040932.496478-6-lihongbo22%40huawei.com
> patch subject: [PATCH v11 05/10] erofs: support user-defined fingerprint name
> config: powerpc-randconfig-001-20251225 (https://download.01.org/0day-ci/archive/20251225/202512251143.WPBiiQZA-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 4ef602d446057dabf5f61fb221669ecbeda49279)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251225/202512251143.WPBiiQZA-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512251143.WPBiiQZA-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> fs/erofs/super.c:302:8: error: no member named 'ishare_xattr_pfx' in 'struct erofs_sb_info'
>       302 |                 sbi->ishare_xattr_pfx =
>           |                 ~~~  ^
>     1 error generated.
> 
> 
> vim +302 fs/erofs/super.c
> 
>     263	
>     264	static int erofs_read_superblock(struct super_block *sb)
>     265	{
>     266		struct erofs_sb_info *sbi = EROFS_SB(sb);
>     267		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>     268		struct erofs_super_block *dsb;
>     269		void *data;
>     270		int ret;
>     271	
>     272		data = erofs_read_metabuf(&buf, sb, 0, false);
>     273		if (IS_ERR(data)) {
>     274			erofs_err(sb, "cannot read erofs superblock");
>     275			return PTR_ERR(data);
>     276		}
>     277	
>     278		dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
>     279		ret = -EINVAL;
>     280		if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
>     281			erofs_err(sb, "cannot find valid erofs superblock");
>     282			goto out;
>     283		}
>     284	
>     285		sbi->blkszbits = dsb->blkszbits;
>     286		if (sbi->blkszbits < 9 || sbi->blkszbits > PAGE_SHIFT) {
>     287			erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
>     288			goto out;
>     289		}
>     290		if (dsb->dirblkbits) {
>     291			erofs_err(sb, "dirblkbits %u isn't supported", dsb->dirblkbits);
>     292			goto out;
>     293		}
>     294	
>     295		sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
>     296		if (erofs_sb_has_sb_chksum(sbi)) {
>     297			ret = erofs_superblock_csum_verify(sb, data);
>     298			if (ret)
>     299				goto out;
>     300		}
>     301		if (erofs_sb_has_ishare_xattrs(sbi))
>   > 302			sbi->ishare_xattr_pfx =
>     303				dsb->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;
>     304	
>     305		ret = -EINVAL;
>     306		sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
>     307		if (sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT) {
>     308			erofs_err(sb, "unidentified incompatible feature %x, please upgrade kernel",
>     309				  sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT);
>     310			goto out;
>     311		}
>     312	
>     313		sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
>     314		if (sbi->sb_size > PAGE_SIZE - EROFS_SUPER_OFFSET) {
>     315			erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
>     316				  sbi->sb_size);
>     317			goto out;
>     318		}
>     319		sbi->dif0.blocks = le32_to_cpu(dsb->blocks_lo);
>     320		sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
>     321	#ifdef CONFIG_EROFS_FS_XATTR

The EROFS_FS_XATTR is disabled, so should put in here.. I will fix it in 
next version.

Thanks,
Hongbo

>     322		sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
>     323		sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
>     324		sbi->xattr_prefix_count = dsb->xattr_prefix_count;
>     325		sbi->xattr_filter_reserved = dsb->xattr_filter_reserved;
>     326	#endif
>     327		sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
>     328		if (erofs_sb_has_48bit(sbi) && dsb->rootnid_8b) {
>     329			sbi->root_nid = le64_to_cpu(dsb->rootnid_8b);
>     330			sbi->dif0.blocks = sbi->dif0.blocks |
>     331					((u64)le16_to_cpu(dsb->rb.blocks_hi) << 32);
>     332		} else {
>     333			sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
>     334		}
>     335		sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
>     336		if (erofs_sb_has_metabox(sbi)) {
>     337			if (sbi->sb_size <= offsetof(struct erofs_super_block,
>     338						     metabox_nid))
>     339				return -EFSCORRUPTED;
>     340			sbi->metabox_nid = le64_to_cpu(dsb->metabox_nid);
>     341			if (sbi->metabox_nid & BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
>     342				return -EFSCORRUPTED;	/* self-loop detection */
>     343		}
>     344		sbi->inos = le64_to_cpu(dsb->inos);
>     345	
>     346		sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
>     347		sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
>     348		super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
>     349	
>     350		if (dsb->volume_name[0]) {
>     351			sbi->volume_name = kstrndup(dsb->volume_name,
>     352						    sizeof(dsb->volume_name), GFP_KERNEL);
>     353			if (!sbi->volume_name)
>     354				return -ENOMEM;
>     355		}
>     356	
>     357		/* parse on-disk compression configurations */
>     358		ret = z_erofs_parse_cfgs(sb, dsb);
>     359		if (ret < 0)
>     360			goto out;
>     361	
>     362		ret = erofs_scan_devices(sb, dsb);
>     363	
>     364		if (erofs_sb_has_48bit(sbi))
>     365			erofs_info(sb, "EXPERIMENTAL 48-bit layout support in use. Use at your own risk!");
>     366		if (erofs_sb_has_metabox(sbi))
>     367			erofs_info(sb, "EXPERIMENTAL metadata compression support in use. Use at your own risk!");
>     368		if (erofs_is_fscache_mode(sb))
>     369			erofs_info(sb, "[deprecated] fscache-based on-demand read feature in use. Use at your own risk!");
>     370	out:
>     371		erofs_put_metabuf(&buf);
>     372		return ret;
>     373	}
>     374	
> 

