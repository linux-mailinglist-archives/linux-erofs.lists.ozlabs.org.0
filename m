Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D375649CC
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Jul 2022 22:54:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lbh513F16z3bnV
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Jul 2022 06:54:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lAs1yHhe;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lAs1yHhe;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lbh4t6sGtz3bb2
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Jul 2022 06:54:22 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1D246611E9;
	Sun,  3 Jul 2022 20:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2A6C341C6;
	Sun,  3 Jul 2022 20:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656881658;
	bh=mUc455W0Zy6jzz+adLcER/y90Gr3Umnb9E/WOunohgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAs1yHheANtiZ8/GKZQiKmGidXPeJqtblAukdojivXXTtwhKuVlc3dDVxgv0MWnw5
	 Y2eZh02KHLMXaPlE9B8GZaUba+wVGnOXzIAg3HHNjswBMZrojDMFzGMptH9lMflSVd
	 TlWCIperfL5n5GBPMqF++MoISZXqcf7MEKAjfqMebGl32p4a8J47NpUapk84CdZczQ
	 WZaMZhL9e4m2SPZ7/9If4Xplu90aMyVwxk18+1Z5uNK2Q+1APU7B/VO0I+kpDCXu5a
	 gXo41661rmvZ5IiOl3yP0xolIkLo2EDo0NwIrdU5wPXEzwIVlpB27e46iFAWOZ9CYz
	 Sd2rkd6+MpHiQ==
Date: Mon, 4 Jul 2022 04:54:13 +0800
From: Gao Xiang <xiang@kernel.org>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v2] Make --mount-point option generally available
Message-ID: <YsIB9eaNlR5VC7b3@debian>
Mail-Followup-To: Kelvin Zhang <zhangkelvin@google.com>,
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
	Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
	Gao Xiang <xiang@kernel.org>
References: <Yr52GGOwNfl6StH6@B-P7TQMD6M-0146.local>
 <20220701230030.2633151-1-zhangkelvin@google.com>
 <Yr/PPRuL/g1E7PIw@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yr/PPRuL/g1E7PIw@B-P7TQMD6M-0146.local>
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jul 02, 2022 at 12:53:17PM +0800, Gao Xiang wrote:
> On Fri, Jul 01, 2022 at 04:00:30PM -0700, Kelvin Zhang wrote:
> > This option does not have any android specific dependencies. It is also
> > useful for all selinux enabled fs images, so move it out of android
> > specific feature sets.
> > 
> > e.g. mkfs.erofs --file-contexts=selinux_context_file
> > --mount_point=/product product.img your_product_out_dir
> > 
> > Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> 
> Apart from the subject without the prefix, Looks good to me,
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Will play with it and apply later...

I tried to apply it to each branch but without any luck.
Would you mind rebasing it?

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
> 
> > ---
> >  include/erofs/config.h | 2 +-
> >  lib/xattr.c            | 2 --
> >  mkfs/main.c            | 6 +++---
> >  3 files changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/erofs/config.h b/include/erofs/config.h
> > index 0a1b18b..030054b 100644
> > --- a/include/erofs/config.h
> > +++ b/include/erofs/config.h
> > @@ -65,8 +65,8 @@ struct erofs_configure {
> >  	u32 c_dict_size;
> >  	u64 c_unix_timestamp;
> >  	u32 c_uid, c_gid;
> > +	const char *mount_point;
> >  #ifdef WITH_ANDROID
> > -	char *mount_point;
> >  	char *target_out_path;
> >  	char *fs_config_file;
> >  	char *block_list_file;
> > diff --git a/lib/xattr.c b/lib/xattr.c
> > index 00fb963..cf5c447 100644
> > --- a/lib/xattr.c
> > +++ b/lib/xattr.c
> > @@ -210,12 +210,10 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
> >  		unsigned int len[2];
> >  		char *kvbuf, *fspath;
> >  
> > -#ifdef WITH_ANDROID
> >  		if (cfg.mount_point)
> >  			ret = asprintf(&fspath, "/%s/%s", cfg.mount_point,
> >  				       erofs_fspath(srcpath));
> >  		else
> > -#endif
> >  			ret = asprintf(&fspath, "/%s", erofs_fspath(srcpath));
> >  		if (ret <= 0)
> >  			return ERR_PTR(-ENOMEM);
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index b62a8aa..879c2f2 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -50,8 +50,8 @@ static struct option long_options[] = {
> >  	{"quiet", no_argument, 0, 12},
> >  	{"blobdev", required_argument, NULL, 13},
> >  	{"ignore-mtime", no_argument, NULL, 14},
> > -#ifdef WITH_ANDROID
> >  	{"mount-point", required_argument, NULL, 512},
> > +#ifdef WITH_ANDROID
> >  	{"product-out", required_argument, NULL, 513},
> >  	{"fs-config-file", required_argument, NULL, 514},
> >  	{"block-list-file", required_argument, NULL, 515},
> > @@ -103,9 +103,9 @@ static void usage(void)
> >  #ifndef NDEBUG
> >  	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
> >  #endif
> > +	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
> >  #ifdef WITH_ANDROID
> >  	      "\nwith following android-specific options:\n"
> > -	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
> >  	      " --product-out=X       X=product_out directory\n"
> >  	      " --fs-config-file=X    X=fs_config file\n"
> >  	      " --block-list-file=X   X=block_list file\n"
> > @@ -314,7 +314,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >  		case 10:
> >  			cfg.c_compress_hints_file = optarg;
> >  			break;
> > -#ifdef WITH_ANDROID
> >  		case 512:
> >  			cfg.mount_point = optarg;
> >  			/* all trailing '/' should be deleted */
> > @@ -322,6 +321,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >  			if (opt && optarg[opt - 1] == '/')
> >  				optarg[opt - 1] = '\0';
> >  			break;
> > +#ifdef WITH_ANDROID
> >  		case 513:
> >  			cfg.target_out_path = optarg;
> >  			break;
> > -- 
> > 2.37.0.rc0.161.g10f37bed90-goog
