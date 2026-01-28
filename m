Return-Path: <linux-erofs+bounces-2239-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHXcIapUemnk5AEAu9opvQ
	(envelope-from <linux-erofs+bounces-2239-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 19:25:46 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7CCA7BB4
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 19:25:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1W123jx5z2xpg;
	Thu, 29 Jan 2026 05:25:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769624742;
	cv=none; b=miDZEhQYlEK1mZAgJ7rFz5KrbgsooKA9ZHdAAaYPkZ67C3dXofFLSjw4LYtjqEk1Q5WnSp9/f1bkKZEFjI3e7xf+X4CPod2wq37eJRrBMW/m3k8QzlYufBHK4UetXsbTxNDDpaVwR1XmMghkFJxDU0CdQMxmkSRIAgy9yxFlveaD4de9HauxfixOhDIT107qI4rRki998dkjbSzg0eEkBMaw3n5/D3mIsOdYUHOQcvDSsOUffHN8km/CecrdZ9tPtvyoqj0qVRpK0gydBGXA0XrXZHNBR/fjOqZRjT6lA7a7cAVg0Z/heqiBH0mMCp02eVSop698MFt6RVVPGExr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769624742; c=relaxed/relaxed;
	bh=Dobr8qF56ahAIpwJk5PQ0IZctSzIItnzqV9I8C66r88=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Tn9xYOq4fYyzF+nP9q03OgnpmFZlgu0TgF8dPCjXYvKkYp2Y601KTrxf+GdvvSYLj5DPeU0sNnr56IV93vIYfGKKmYpvBxrhMqxY+X0ad2eLCd1sEvsMUmGTfOvNhMOY2ZTbdNsKbM1cZoME11OqJxEZdVrGgCXzkReo4fJi8nmCPSwVF95bEdJtbzTmjeu3KgsSy/8zHIC6EykKqdPm4C1dgFLlVPuM5uX1caTsTBktWmtkhMvvr49D/AudN+0KdpGL5tc1tBSSSMa18OWMjBpTG5mgg5rQjfF9TXWbAn7a9VKHLlj5a8wkVMXdylhVrxxJ0meNvi4UD+a8zOOPVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MgKVqMJz; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MgKVqMJz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1W113f2tz2xlK
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Jan 2026 05:25:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769624742; x=1801160742;
  h=date:from:to:cc:subject:message-id;
  bh=zBDmzMiBBJRmKfwPxi54gkScfvzMSz4FRALJ+ugDFnM=;
  b=MgKVqMJz926F/e7uNp304whOF2nsGd59PkmeorL4p9mqsSgglz5RWBgC
   a0hD//KaJQ3Nyj7ahs29/52oa/3+n0qyyGiJaU5xjqABfFcyUHujJQhxD
   rzqtvm8PaakCrQA4OFZqyOShxk4b5h282df8NuVmQMpqwzhbFowG6sckB
   TZGxRs2r8Y2zyFnuXZtMnDVJfb5Yxv9YA+vBuFDDaM4pa78xb+7IMJlyK
   KmVUjehxwYzzx6dS17t+U7cHdq7G+MfzITfGbUZNvA75YCkT6MzbAeksm
   Cg6HeorDw4PuAfQ10IW/Dgg6Ru8h+D1i5tNE3pUJzzDoKrLaO0KIUrUF7
   Q==;
X-CSE-ConnectionGUID: Nh1SfR9sRCm7ASQ9riBhOw==
X-CSE-MsgGUID: 54z2pM55TNeJrPH3Jfiv9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="69862427"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="69862427"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 10:25:39 -0800
X-CSE-ConnectionGUID: ZVkQLlfoS8CLz2Rmux+t/w==
X-CSE-MsgGUID: 3bZxDb1aR7O7qR2LB5oflQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="245937771"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Jan 2026 10:25:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlAEP-00000000ags-38M1;
	Wed, 28 Jan 2026 18:25:33 +0000
Date: Thu, 29 Jan 2026 02:24:34 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test 27/27] fs/erofs/inode.c:182:19: error:
 no member named 'available_compr_algs' in 'struct erofs_sb_info'
Message-ID: <202601290258.TBdbezPx-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2239-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 5F7CCA7BB4
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   713acdda5f818fb4f2286238a4f9f1f5f519b9da
commit: 713acdda5f818fb4f2286238a4f9f1f5f519b9da [27/27] erofs: separate plain and compressed filesystems formally
config: i386-buildonly-randconfig-002-20260128 (https://download.01.org/0day-ci/archive/20260129/202601290258.TBdbezPx-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260129/202601290258.TBdbezPx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601290258.TBdbezPx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/erofs/inode.c:182:19: error: no member named 'available_compr_algs' in 'struct erofs_sb_info'
     182 |         } else if (!sbi->available_compr_algs) {
         |                     ~~~  ^
   1 error generated.


vim +182 fs/erofs/inode.c

    29	
    30	static int erofs_read_inode(struct inode *inode)
    31	{
    32		struct super_block *sb = inode->i_sb;
    33		erofs_blk_t blkaddr = erofs_blknr(sb, erofs_iloc(inode));
    34		unsigned int ofs = erofs_blkoff(sb, erofs_iloc(inode));
    35		bool in_mbox = erofs_inode_in_metabox(inode);
    36		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
    37		struct erofs_sb_info *sbi = EROFS_SB(sb);
    38		erofs_blk_t addrmask = BIT_ULL(48) - 1;
    39		struct erofs_inode *vi = EROFS_I(inode);
    40		struct erofs_inode_extended *die, copied;
    41		struct erofs_inode_compact *dic;
    42		unsigned int ifmt;
    43		void *ptr;
    44		int err = 0;
    45	
    46		ptr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), in_mbox);
    47		if (IS_ERR(ptr)) {
    48			err = PTR_ERR(ptr);
    49			erofs_err(sb, "failed to read inode meta block (nid: %llu): %d",
    50				  vi->nid, err);
    51			goto err_out;
    52		}
    53	
    54		dic = ptr + ofs;
    55		ifmt = le16_to_cpu(dic->i_format);
    56		if (ifmt & ~EROFS_I_ALL) {
    57			erofs_err(sb, "unsupported i_format %u of nid %llu",
    58				  ifmt, vi->nid);
    59			err = -EOPNOTSUPP;
    60			goto err_out;
    61		}
    62	
    63		vi->datalayout = erofs_inode_datalayout(ifmt);
    64		if (vi->datalayout >= EROFS_INODE_DATALAYOUT_MAX) {
    65			erofs_err(sb, "unsupported datalayout %u of nid %llu",
    66				  vi->datalayout, vi->nid);
    67			err = -EOPNOTSUPP;
    68			goto err_out;
    69		}
    70	
    71		switch (erofs_inode_version(ifmt)) {
    72		case EROFS_INODE_LAYOUT_EXTENDED:
    73			vi->inode_isize = sizeof(struct erofs_inode_extended);
    74			/* check if the extended inode acrosses block boundary */
    75			if (ofs + vi->inode_isize <= sb->s_blocksize) {
    76				ofs += vi->inode_isize;
    77				die = (struct erofs_inode_extended *)dic;
    78				copied.i_u = die->i_u;
    79				copied.i_nb = die->i_nb;
    80			} else {
    81				const unsigned int gotten = sb->s_blocksize - ofs;
    82	
    83				memcpy(&copied, dic, gotten);
    84				ptr = erofs_read_metabuf(&buf, sb,
    85						erofs_pos(sb, blkaddr + 1), in_mbox);
    86				if (IS_ERR(ptr)) {
    87					err = PTR_ERR(ptr);
    88					erofs_err(sb, "failed to read inode payload block (nid: %llu): %d",
    89						  vi->nid, err);
    90					goto err_out;
    91				}
    92				ofs = vi->inode_isize - gotten;
    93				memcpy((u8 *)&copied + gotten, ptr, ofs);
    94				die = &copied;
    95			}
    96			vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
    97	
    98			inode->i_mode = le16_to_cpu(die->i_mode);
    99			i_uid_write(inode, le32_to_cpu(die->i_uid));
   100			i_gid_write(inode, le32_to_cpu(die->i_gid));
   101			set_nlink(inode, le32_to_cpu(die->i_nlink));
   102			inode_set_mtime(inode, le64_to_cpu(die->i_mtime),
   103					le32_to_cpu(die->i_mtime_nsec));
   104	
   105			inode->i_size = le64_to_cpu(die->i_size);
   106			break;
   107		case EROFS_INODE_LAYOUT_COMPACT:
   108			vi->inode_isize = sizeof(struct erofs_inode_compact);
   109			ofs += vi->inode_isize;
   110			vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
   111	
   112			inode->i_mode = le16_to_cpu(dic->i_mode);
   113			copied.i_u = dic->i_u;
   114			i_uid_write(inode, le16_to_cpu(dic->i_uid));
   115			i_gid_write(inode, le16_to_cpu(dic->i_gid));
   116			if (!S_ISDIR(inode->i_mode) &&
   117			    ((ifmt >> EROFS_I_NLINK_1_BIT) & 1)) {
   118				set_nlink(inode, 1);
   119				copied.i_nb = dic->i_nb;
   120			} else {
   121				set_nlink(inode, le16_to_cpu(dic->i_nb.nlink));
   122				copied.i_nb.startblk_hi = 0;
   123				addrmask = BIT_ULL(32) - 1;
   124			}
   125			inode_set_mtime(inode, sbi->epoch + le32_to_cpu(dic->i_mtime),
   126					sbi->fixed_nsec);
   127	
   128			inode->i_size = le32_to_cpu(dic->i_size);
   129			break;
   130		default:
   131			erofs_err(sb, "unsupported on-disk inode version %u of nid %llu",
   132				  erofs_inode_version(ifmt), vi->nid);
   133			err = -EOPNOTSUPP;
   134			goto err_out;
   135		}
   136	
   137		if (unlikely(inode->i_size < 0)) {
   138			erofs_err(sb, "negative i_size @ nid %llu", vi->nid);
   139			err = -EFSCORRUPTED;
   140			goto err_out;
   141		}
   142	
   143		if (IS_ENABLED(CONFIG_EROFS_FS_POSIX_ACL) &&
   144		    erofs_inode_has_noacl(inode, ptr, ofs))
   145			cache_no_acl(inode);
   146	
   147		switch (inode->i_mode & S_IFMT) {
   148		case S_IFDIR:
   149			vi->dot_omitted = (ifmt >> EROFS_I_DOT_OMITTED_BIT) & 1;
   150			fallthrough;
   151		case S_IFREG:
   152		case S_IFLNK:
   153			vi->startblk = le32_to_cpu(copied.i_u.startblk_lo) |
   154				((u64)le16_to_cpu(copied.i_nb.startblk_hi) << 32);
   155			if (vi->datalayout == EROFS_INODE_FLAT_PLAIN &&
   156			    !((vi->startblk ^ EROFS_NULL_ADDR) & addrmask))
   157				vi->startblk = EROFS_NULL_ADDR;
   158	
   159			if(S_ISLNK(inode->i_mode)) {
   160				err = erofs_fill_symlink(inode, ptr, ofs);
   161				if (err)
   162					goto err_out;
   163			}
   164			break;
   165		case S_IFCHR:
   166		case S_IFBLK:
   167			inode->i_rdev = new_decode_dev(le32_to_cpu(copied.i_u.rdev));
   168			break;
   169		case S_IFIFO:
   170		case S_IFSOCK:
   171			inode->i_rdev = 0;
   172			break;
   173		default:
   174			erofs_err(sb, "bogus i_mode (%o) @ nid %llu", inode->i_mode,
   175				  vi->nid);
   176			err = -EFSCORRUPTED;
   177			goto err_out;
   178		}
   179	
   180		if (!erofs_inode_is_data_compressed(vi->datalayout)) {
   181			inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
 > 182		} else if (!sbi->available_compr_algs) {
   183			erofs_err(sb, "compressed inode (nid %llu) is invalid in a plain filesystem",
   184				  vi->nid);
   185			err = -EFSCORRUPTED;
   186			goto err_out;
   187		} else {
   188			inode->i_blocks = le32_to_cpu(copied.i_u.blocks_lo) <<
   189					(sb->s_blocksize_bits - 9);
   190		}
   191	
   192		if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
   193			/* fill chunked inode summary info */
   194			vi->chunkformat = le16_to_cpu(copied.i_u.c.format);
   195			if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
   196				erofs_err(sb, "unsupported chunk format %x of nid %llu",
   197					  vi->chunkformat, vi->nid);
   198				err = -EOPNOTSUPP;
   199				goto err_out;
   200			}
   201			vi->chunkbits = sb->s_blocksize_bits +
   202				(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
   203		}
   204		inode_set_atime_to_ts(inode,
   205				      inode_set_ctime_to_ts(inode, inode_get_mtime(inode)));
   206	
   207		inode->i_flags &= ~S_DAX;
   208		if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
   209		    (vi->datalayout == EROFS_INODE_FLAT_PLAIN ||
   210		     vi->datalayout == EROFS_INODE_CHUNK_BASED))
   211			inode->i_flags |= S_DAX;
   212	err_out:
   213		erofs_put_metabuf(&buf);
   214		return err;
   215	}
   216	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

