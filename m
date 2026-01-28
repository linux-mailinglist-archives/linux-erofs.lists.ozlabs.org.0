Return-Path: <linux-erofs+bounces-2238-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNunNBlSemnk5AEAu9opvQ
	(envelope-from <linux-erofs+bounces-2238-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 19:14:49 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61690A79A8
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 19:14:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1VmP65v5z2xlK;
	Thu, 29 Jan 2026 05:14:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769624085;
	cv=none; b=JJTafiLcep+d++zG1ovyOAF+K8k3gxsxur29pi20LzorAB4jv3FO/2AjKH7Up9sx3fVThPyUfPyBEURSXXJ9crCRC6euy+WJ4iSQRedFdGt2sxIkMEeoKXTqdHvMZFsUHHeoevtkZr3fNHtHlsvO5SUc+AwcI0hCtKicDBoMZDlYB5viJRUtvpQOnitaoPueb0wSrcXtSW715rjZT3fKvNKje+Jakil5JIcyFAJmDdXQ03K0WmP3/TauanIDXFl2as8J0NwQbJsiL9RpPeqAyMOP5afOHF622uLMbHl/+T6lH+eI+MguvyZPbwui0KCfvDe/2C+U91Ap+hoRPD3XtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769624085; c=relaxed/relaxed;
	bh=3xznZT3TqZfANiFVlVxY6Zi4SUtY7cjyWyuS+hxQAEg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iZl2sdQvPla2yAxheUr4cossSn9YGrdGZ75jBPfB27vQhyWkkphDGCt0fPmX33lIKppm4KDMnoUjTlaY4TFl3hCp6/J1i/uQi1UTSNAGc81HUNLF+JdI0//gkN4n5S73j5/7wsR9b2Tp61IzpUlM7MUWp5/RePfWAuQy27iJC+55FtYW6JM5VmTdIQFexS2Tzm23Ur54EFjbqEP/yhgwMmct9IW2LxHMPCkLcxBZwamNLJjXzU4dup1FoWp+n/EvOIAPjcx1bxgaF6BAvPiZmx/Lj3xIN6N0CG4XJA9KK9mDzVH+rdHag/CA6cEG9APUdi4EAjL377KmliqPf2NdHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U8wpxPMi; dkim-atps=neutral; spf=pass (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U8wpxPMi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1VmJ1wPlz2xgv
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Jan 2026 05:14:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769624080; x=1801160080;
  h=date:from:to:cc:subject:message-id;
  bh=5zl4G6JaD6BY8PsLIpUfJ7O/IiqaMSb3HRxS8lFnPHA=;
  b=U8wpxPMi+XPDgFAveNQm4UeL6P47HMVVFd1SVOAZZBRpVqLb80tHlmYM
   hWULUfsbQeuRc83g4qjt70OIK572orb0tW/Kte751605L+1Od6mToPqoQ
   8PTGEsoG0Ev/wPY87Swrld2hKYKBQnTqF8dhqkpc0UreAaQOZcML0UkQe
   IsoS+J9dcOyuuXzndxX4coTZzc4BGm2Eh5/pKuZk6PBFdYsShNWw8JJL6
   DO7Qg2N3HcBZ7AYnuCbWIUvE+CL64icY0R7pPwY+pKkXbXhY6JD8Y+B/o
   AVHaWcT3gQbNw2/glBQuuOt5iKrsfaVF2UN8a9/IAsG5o+IFldXx0S6Cx
   w==;
X-CSE-ConnectionGUID: gBXvsHZnT0C4TD4M+1ckjg==
X-CSE-MsgGUID: m8WJnyd5Q3+aPynDzUDZNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70937356"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70937356"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 10:14:35 -0800
X-CSE-ConnectionGUID: XHGAEYBdQga/nudaGt9t3w==
X-CSE-MsgGUID: QDWYxLw5TRK41QOba3Td4Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Jan 2026 10:14:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlA3i-00000000ag0-3Bt9;
	Wed, 28 Jan 2026 18:14:30 +0000
Date: Thu, 29 Jan 2026 02:13:42 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, Xiang Gao <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test 27/27] fs/erofs/inode.c:182:24: error:
 'struct erofs_sb_info' has no member named 'available_compr_algs'
Message-ID: <202601290220.4nKd6hHT-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-2238-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:oe-kbuild-all@lists.linux.dev,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 61690A79A8
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   713acdda5f818fb4f2286238a4f9f1f5f519b9da
commit: 713acdda5f818fb4f2286238a4f9f1f5f519b9da [27/27] erofs: separate plain and compressed filesystems formally
config: sparc64-randconfig-001-20260128 (https://download.01.org/0day-ci/archive/20260129/202601290220.4nKd6hHT-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260129/202601290220.4nKd6hHT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601290220.4nKd6hHT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/div64.h:27,
                    from ./arch/sparc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/fs_dirent.h:5,
                    from include/linux/fs/super_types.h:5,
                    from include/linux/fs/super.h:5,
                    from include/linux/fs.h:5,
                    from fs/erofs/internal.h:10,
                    from fs/erofs/xattr.h:9,
                    from fs/erofs/inode.c:7:
   fs/erofs/inode.c: In function 'erofs_read_inode':
>> fs/erofs/inode.c:182:24: error: 'struct erofs_sb_info' has no member named 'available_compr_algs'
     182 |         } else if (!sbi->available_compr_algs) {
         |                        ^~
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   fs/erofs/inode.c:182:16: note: in expansion of macro 'if'
     182 |         } else if (!sbi->available_compr_algs) {
         |                ^~
>> fs/erofs/inode.c:182:24: error: 'struct erofs_sb_info' has no member named 'available_compr_algs'
     182 |         } else if (!sbi->available_compr_algs) {
         |                        ^~
   include/linux/compiler.h:57:61: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   fs/erofs/inode.c:182:16: note: in expansion of macro 'if'
     182 |         } else if (!sbi->available_compr_algs) {
         |                ^~
>> fs/erofs/inode.c:182:24: error: 'struct erofs_sb_info' has no member named 'available_compr_algs'
     182 |         } else if (!sbi->available_compr_algs) {
         |                        ^~
   include/linux/compiler.h:68:10: note: in definition of macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   fs/erofs/inode.c:182:16: note: in expansion of macro 'if'
     182 |         } else if (!sbi->available_compr_algs) {
         |                ^~


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

