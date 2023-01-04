Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E865CD7D
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 08:08:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nn1096VYHz3c83
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 18:08:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Lv2vWJcE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Lv2vWJcE;
	dkim-atps=neutral
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nn0zW182Pz3c6f
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 18:07:34 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id 18so10014012pfx.7
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Jan 2023 23:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAnPmusiGkaXMbPIgPezEQruhae3QgCmD8vEB1pasVo=;
        b=Lv2vWJcEbrHDtKmM/pTfLZNFNLBHHVx/xCXTYKgpLNBp0lfvsd3hhDnBJHAGT7YOFI
         fwG4PcTV36Vi+EpBQCNnN6tOdaB0YpizKJUwNU6XJ8Z9o39AGr02R6ghX/XRNLgb3NRV
         9XZunyG1a1Jr4fAmy4uT/6rAxL3I4bgFbeTN4wZV0+oT3EXYRvUkzqHoxqFaZZ69Gc5h
         O88UK7R2t5djpRM03uLHb35i6fXmc9gUsFfM8IfdbNXu0lZ/AdEnz2dfhlPbOQ3PgRW2
         TiHaQ69IXBaR3b+SXO9Z3BOiF/08gQKFhJysYPwXf4oRVXGO1SfGD4sAvy8TkarYt8Ar
         hj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAnPmusiGkaXMbPIgPezEQruhae3QgCmD8vEB1pasVo=;
        b=CLHEHuyyjx2m8/Q1KXqP2EcuGQ6IBnZu1Jbg9X9vrZe0mFf8RpC2+24FbzMQk6dSyt
         OU/FzHWyxdE6Cj8sMPOp24cNlk5tzUtM5Jg/fYAjE2OW5x67o/y/kE/o5Qiz5zcP/6Mn
         6UkZT9y1Jo30agSL11cVPMZG45gqDUKTbTBMmguhhe4VPvPzcZ092x9FFpffloXGoJIG
         owuLBEE046geGvTeH6mNmj195Z7VU/YNrQXrUWFz0T71XdaVSw6G8vUwwZ6BucnZ+pFv
         pmbi8HsNsj5AVB0hAipw31M2GXU9Ix51Lq/rfVBl2x1RSQ2STSiR3Aj/GiaAUrcy8k37
         dwvQ==
X-Gm-Message-State: AFqh2koNAk6DE1olQ51/z31MqaCKAklKKurJzALIBfd0PAvB8WpO+8V/
	7+MJ8ATWr19DWTZd73p7+00=
X-Google-Smtp-Source: AMrXdXsQLhBS6hWHcQMQeeVO+uFB99XTOObVI37ujxxobI9PkPBPbh7eJUthXzuMRUM5fCMtmnaJxg==
X-Received: by 2002:a05:6a00:3312:b0:583:6e:550c with SMTP id cq18-20020a056a00331200b00583006e550cmr396304pfb.10.1672816051134;
        Tue, 03 Jan 2023 23:07:31 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id i127-20020a625485000000b005769cee6735sm21726197pfb.43.2023.01.03.23.07.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jan 2023 23:07:30 -0800 (PST)
Date: Wed, 4 Jan 2023 15:12:28 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Xiang Gao <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 2/2] erofs-utils: dump: support fragments
Message-ID: <20230104151228.00002c49.zbestahu@gmail.com>
In-Reply-To: <f9d113dc-134a-bdef-34e2-672bb5220b0c@linux.alibaba.com>
References: <0e4797ef5f22ac3c2134aa4b005c489c233d2eec.1671443064.git.huyue2@coolpad.com>
	<8c66d0d7b0d4f5fa18566bedeaa0b38458b97aa7.1671443064.git.huyue2@coolpad.com>
	<443a1f23-451a-c964-442b-843519ce9ec9@linux.alibaba.com>
	<20230104141635.000061b1.zbestahu@gmail.com>
	<f9d113dc-134a-bdef-34e2-672bb5220b0c@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 4 Jan 2023 14:44:35 +0800
Xiang Gao <hsiangkao@linux.alibaba.com> wrote:

> On 2023/1/4 14:16, Yue Hu wrote:
> > Hi Xiang,
> > 
> > Thanks for the reviewing. I'm planning to send v2.
> > 
> > On Wed, 4 Jan 2023 11:13:55 +0800
> > Xiang Gao <hsiangkao@linux.alibaba.com> wrote:
> >   
> >> On 2022/12/19 17:50, Yue Hu wrote:  
> >>> From: Yue Hu <huyue2@coolpad.com>
> >>>
> >>> Add compressed fragments support for dump feature.
> >>>
> >>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> >>> ---
> >>>    dump/main.c              | 78 ++++++++++++++++++++++++++++++++--------
> >>>    include/erofs/internal.h |  1 +
> >>>    lib/zmap.c               |  2 +-
> >>>    3 files changed, 65 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/dump/main.c b/dump/main.c
> >>> index bc4f047..d387841 100644
> >>> --- a/dump/main.c
> >>> +++ b/dump/main.c
> >>> @@ -14,6 +14,8 @@
> >>>    #include "erofs/inode.h"
> >>>    #include "erofs/io.h"
> >>>    #include "erofs/dir.h"
> >>> +#include "erofs/compress.h"
> >>> +#include "erofs/fragments.h"
> >>>    #include "../lib/liberofs_private.h"
> >>>    
> >>>    #ifdef HAVE_LIBUUID
> >>> @@ -96,6 +98,7 @@ static struct erofsdump_feature feature_lists[] = {
> >>>    	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
> >>>    	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
> >>>    	{ false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
> >>> +	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
> >>>    };
> >>>    
> >>>    static int erofsdump_readdir(struct erofs_dir_context *ctx);
> >>> @@ -285,10 +288,12 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
> >>>    	}
> >>>    
> >>>    	if (S_ISREG(vi.i_mode)) {
> >>> -		stats.files_total_origin_size += vi.i_size;
> >>> -		inc_file_extension_count(ctx->dname, ctx->de_namelen);
> >>> +		if (!erofs_is_packed_inode(&vi)) {
> >>> +			stats.files_total_origin_size += vi.i_size;
> >>> +			inc_file_extension_count(ctx->dname, ctx->de_namelen);
> >>> +			update_file_size_statistics(vi.i_size, true);
> >>> +		}
> >>>    		stats.files_total_size += occupied_size;
> >>> -		update_file_size_statistics(vi.i_size, true);
> >>>    		update_file_size_statistics(occupied_size, false);
> >>>    	}
> >>>    
> >>> @@ -320,6 +325,10 @@ static void erofsdump_show_fileinfo(bool show_extent)
> >>>    		"%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 " : %10" PRIu64 "..%10" PRIu64 " | %7" PRIu64 "\n",
> >>>    		"%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 " : %10" PRIu64 "..%10" PRIu64 " | %7" PRIu64 "  # device %u\n"
> >>>    	};
> >>> +	const char *frag_ext_fmt[] = {
> >>> +		"%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 "\n",
> >>> +		"%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 "  # device %u\n"
> >>> +	};  
> >>
> >> Why do we need another fmt rather than just fill fragment extent with  
> > 
> > I also plan to remove this fmt in v2.
> >   
> >> physical addr 0?  
> > 
> > Okay. Just leave latter physical length as empty?
> >   
> >>  
> >>>    	int err, i;
> >>>    	erofs_off_t size;
> >>>    	u16 access_mode;
> >>> @@ -348,16 +357,31 @@ static void erofsdump_show_fileinfo(bool show_extent)
> >>>    		}
> >>>    	}
> >>>    
> >>> +	if (erofs_inode_is_data_compressed(inode.datalayout)) {
> >>> +		err = z_erofs_fill_inode_lazy(&inode);
> >>> +		if (err) {
> >>> +			erofs_err("read inode map header failed @ nid %llu",
> >>> +				  inode.nid | 0ULL);
> >>> +			return;
> >>> +		}
> >>> +	}  
> >>
> >> Why do we need to call z_erofs_fill_inode_lazy here?  
> > 
> > Used to check if the file has fragment. If yes, i think 'Compression ratio' can not be showed
> > exactly.
> > 
> > So, I'd like to show fragment information related instead as below:
> > 
> > NID: 715   Links: 1   Layout: 1   Fragment: entire file
> > 
> > NID: 715   Links: 1   Layout: 3   Fragment: tail of file  
> 
> I think no need to distinguish these two stuffs considering extra 
> complexity.

So, no need to check fragment or not? just keep the original look?

> 
> >   
> >>  
> >>> +
> >>>    	err = erofs_get_occupied_size(&inode, &size);
> >>>    	if (err) {
> >>>    		erofs_err("get file size failed @ nid %llu", inode.nid | 0ULL);
> >>>    		return;
> >>>    	}
> >>>    
> >>> -	err = erofs_get_pathname(inode.nid, path, sizeof(path));
> >>> -	if (err < 0) {
> >>> -		erofs_err("file path not found @ nid %llu", inode.nid | 0ULL);
> >>> -		return;  
> >>
> >> Can we just ignore pathname if it doesn't exist?  
> > 
> > Okay.
> >   
> >>  
> >>> +	if (erofs_is_packed_inode(&inode) { > +		strncpy(path, EROFS_PACKED_INODE, sizeof(path) - 1);
> >>> +		path[sizeof(path) - 1] = '\0';
> >>> +	} else {
> >>> +		err = erofs_get_pathname(inode.nid, path, sizeof(path));
> >>> +		if (err < 0) {
> >>> +			erofs_err("file path not found @ nid %llu",
> >>> +				  inode.nid | 0ULL);
> >>> +			return;
> >>> +		}
> >>>    	}
> >>>    
> >>>    	strftime(timebuf, sizeof(timebuf),
> >>> @@ -372,9 +396,13 @@ static void erofsdump_show_fileinfo(bool show_extent)
> >>>    		file_category_types[erofs_mode_to_ftype(inode.i_mode)]);
> >>>    	fprintf(stdout, "NID: %" PRIu64 "   ", inode.nid);
> >>>    	fprintf(stdout, "Links: %u   ", inode.i_nlink);
> >>> -	fprintf(stdout, "Layout: %d   Compression ratio: %.2f%%\n",
> >>> -		inode.datalayout,
> >>> -		(double)(100 * size) / (double)(inode.i_size));
> >>> +	if (inode.z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
> >>> +		fprintf(stdout, "Layout: %d   Fragment: %s\n",
> >>> +			inode.datalayout, size ? "partial" : "full");
> >>> +	else
> >>> +		fprintf(stdout, "Layout: %d   Compression ratio: %.2f%%\n",
> >>> +			inode.datalayout,
> >>> +			(double)(100 * size) / (double)(inode.i_size));
> >>>    	fprintf(stdout, "Inode size: %d   ", inode.inode_isize);
> >>>    	fprintf(stdout, "Extent size: %u   ", inode.extent_isize);
> >>>    	fprintf(stdout,	"Xattr size: %u\n", inode.xattr_isize);
> >>> @@ -404,7 +432,8 @@ static void erofsdump_show_fileinfo(bool show_extent)
> >>>    	if (!dumpcfg.show_extent)
> >>>    		return;
> >>>    
> >>> -	fprintf(stdout, "\n Ext:   logical offset   |  length :     physical offset    |  length\n");
> >>> +	fprintf(stdout, "\n Ext:   logical offset   |  length%s\n",
> >>> +			size ? " :     physical offset    |  length" : "");
> >>>    	while (map.m_la < inode.i_size) {
> >>>    		struct erofs_map_dev mdev;
> >>>    
> >>> @@ -425,10 +454,17 @@ static void erofsdump_show_fileinfo(bool show_extent)
> >>>    			return;
> >>>    		}
> >>>    
> >>> -		fprintf(stdout, ext_fmt[!!mdev.m_deviceid], extent_count++,
> >>> -			map.m_la, map.m_la + map.m_llen, map.m_llen,
> >>> -			mdev.m_pa, mdev.m_pa + map.m_plen, map.m_plen,
> >>> -			mdev.m_deviceid);
> >>> +		if (map.m_flags & EROFS_MAP_FRAGMENT)
> >>> +			fprintf(stdout, frag_ext_fmt[!!mdev.m_deviceid],
> >>> +				extent_count++,
> >>> +				map.m_la, map.m_la + map.m_llen, map.m_llen,
> >>> +				mdev.m_deviceid);  
> >>
> >> except for the last fragment extent, the other extents all have physical
> >> addr and length...  
> > 
> > It's true.
> > 
> > What bothers me is how to better show fragment extent based on current format (especially
> > no physical address and offset for fragment extent).
> > 
> > Now, i think the fragment extent should be showed like below (just use a '0' to represent it)?
> > 
> > a) the whole file is a fragment:
> > 
> >   Ext:   logical offset   |  length :     physical offset    |  length
> >     1:        0..    1046 |    1046 :    0  
> 
> 
> Can we use
>     Ext:   logical offset   |  length :     physical offset    |  length
>       1:        0..    1046 |    1046 :     0..0               |  0
> 
> > 
> > b) the tail of file is a fragment:
> > 
> >   Ext:   logical offset   |  length :     physical offset    |  length
> >     0:        0..   19672 |   19672 :    1314816..   1323008 |    8192
> >      ...
> >    13:   165989..  182474 |   16485 :    1421312..   1429504 |    8192
> >    14:   182474..  196435 |   13961 :    0  
> 
> Here
>       14:   182474..  196435 |   13961 :    0..         0       |    0
> 
> as well?

No problem now.

> 
> >   
> >>  
> >>> +		else
> >>> +			fprintf(stdout, ext_fmt[!!mdev.m_deviceid],
> >>> +				extent_count++,
> >>> +				map.m_la, map.m_la + map.m_llen, map.m_llen,
> >>> +				mdev.m_pa, mdev.m_pa + map.m_plen, map.m_plen,
> >>> +				mdev.m_deviceid);
> >>>    		map.m_la += map.m_llen;
> >>>    	}
> >>>    	fprintf(stdout, "%s: %d extents found\n", path, extent_count);
> >>> @@ -537,6 +573,15 @@ static void erofsdump_print_statistic(void)
> >>>    		erofs_err("read dir failed");
> >>>    		return;
> >>>    	}
> >>> +	if (erofs_sb_has_fragments()) {
> >>> +		err = erofsdump_readdir(&(struct erofs_dir_context) {
> >>> +					.de_nid = sbi.packed_nid
> >>> +					});  
> >>
> >> why do we need this?  
> > 
> > Since some status need to be updated such as stats.files_total_size.  
> 
> why should packed file be recorded in files_total_size?

Mainly related to compression ratio. files_total_size records on-disk (un)compressed size.

296                 stats.files_total_size += occupied_size;

544         stats.compress_rate = (double)(100 * stats.files_total_size) /
545                 (double)(stats.files_total_origin_size);

The file system compression ratio will be incorrect (since all compressed fragments are
missing).

> 
> Thanks,
> Gao Xiang
> 
> >   
> >>
> >> Thanks,
> >> Gao Xiang  

