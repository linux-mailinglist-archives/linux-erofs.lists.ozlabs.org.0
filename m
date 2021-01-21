Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7832FF90A
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 00:45:57 +0100 (CET)
Received: from bilbo.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMJtV3VmXzDrRF
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 10:45:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=O3gZgSum; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O3gZgSum; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMJt92WShzDqWL
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 10:45:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611272732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=onD0PKUyj/M70afAaW1Ju56pIt386YsOq3syY15imCA=;
 b=O3gZgSumMmboy3TuybHlB/PiXpTpRvujDhjjs+SzsmTRC6UTTY12BlexxAaCwKYYJ6Dbb/
 +ZqWPdPEndZ0IqxqMQmt//tFdDEEBMRZBue9Vz60Dj+YnmMacoYvabOpez0sX9dTb/yw4B
 DmAD9ZUsC13XffHnusao+XfZANwtGus=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611272732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=onD0PKUyj/M70afAaW1Ju56pIt386YsOq3syY15imCA=;
 b=O3gZgSumMmboy3TuybHlB/PiXpTpRvujDhjjs+SzsmTRC6UTTY12BlexxAaCwKYYJ6Dbb/
 +ZqWPdPEndZ0IqxqMQmt//tFdDEEBMRZBue9Vz60Dj+YnmMacoYvabOpez0sX9dTb/yw4B
 DmAD9ZUsC13XffHnusao+XfZANwtGus=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-xgc2y_VyPPySFNFZ3o-EKg-1; Thu, 21 Jan 2021 18:45:25 -0500
X-MC-Unique: xgc2y_VyPPySFNFZ3o-EKg-1
Received: by mail-pj1-f71.google.com with SMTP id ep24so2294652pjb.5
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 15:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=onD0PKUyj/M70afAaW1Ju56pIt386YsOq3syY15imCA=;
 b=cu9T6QYolCEoi3yuHpTl4KsnENWjuM9Tug48ygk3dk2j84DeDPUCwhcUs+zpbve1Od
 GG9JaJA7PcRrM1DXUqkYvQvZbG1Fdq1oPDAxIKFHbd2BfrK1zGToq+JcHhQHdMnrA5aq
 fOycTgfsUPs9BGn+QfcD0hAhk5YFEGYoqUKZuplgFmAa0O/+zPJ0j6MaJpwned0mCoQW
 SP/tPbQgjr//AmAPWd3quhQoGrsnIvZJSyXNmk6lWiUYqyDGzu5ZZKDTwVSIJ9q+QkDx
 Y2CllX5cVKhWLlvITghgOwSpKyxIXOY1veKmjYCsNFqB5VmgN91hfFGgvkhxKoqhM2B3
 1KRA==
X-Gm-Message-State: AOAM532B+Q0ra9/I5TPQyZFBDGUOmEOJh7lxMVjhS5OZoxkdkZcy8qA0
 aky4xkHsxx98FaXp4c4ZyYL4z9xgP8xAvymN+OrN9nBwACoN/SnMFa/BVvf46pDh8F49mCCpKSt
 9ESDZD2/DZc0/H21AqX3ggVQ9
X-Received: by 2002:a63:4e63:: with SMTP id o35mr1741392pgl.291.1611272724037; 
 Thu, 21 Jan 2021 15:45:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOJDsa94XOYoSNas4mzIVWftMQOKtakPb4EwvT2i7xqze3+eR/qeK6gjNh2vJMxI4X54s07w==
X-Received: by 2002:a63:4e63:: with SMTP id o35mr1741359pgl.291.1611272723574; 
 Thu, 21 Jan 2021 15:45:23 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b65sm7087650pga.54.2021.01.21.15.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 15:45:23 -0800 (PST)
Date: Fri, 22 Jan 2021 07:45:13 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH 3/7] erofs-utils: tests: fix memory leakage in fssum
Message-ID: <20210121234513.GB2996701@xiangao.remote.csb>
References: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
 <20210121163715.10660-4-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210121163715.10660-4-sehuww@mail.scut.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Weiwen,

On Fri, Jan 22, 2021 at 12:37:11AM +0800, Hu Weiwen wrote:
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

It just synced up with fstests, if you'd like to fix memory leakage of
this program. How about sending out it to fstests community directly?
fstests <fstests@vger.kernel.org>
and
https://lore.kernel.org/fstests/

So newer fssum here can be synced up again... (Also, kindly reminder,
before you submit it to fstests community, it'd be better leave some
commit message rather than leave it empty, since empty commit messge
(I mean only SOB) is somewhat uncommon for linux community...)

Thanks,
Gao Xiang

> ---
>  tests/src/fssum.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/src/fssum.c b/tests/src/fssum.c
> index 10d6275..0f40452 100644
> --- a/tests/src/fssum.c
> +++ b/tests/src/fssum.c
> @@ -31,6 +31,7 @@
>  #include <endian.h>
>  
>  #define CS_SIZE 16
> +#define CS_STR_SIZE (CS_SIZE * 2 + 1)
>  #define CHUNKS	128
>  
>  #ifdef __linux__
> @@ -209,16 +210,13 @@ sum_add_time(sum_t *dst, time_t t)
>  	sum_add_u64(dst, t);
>  }
>  
> -char *
> -sum_to_string(sum_t *dst)
> +void
> +sum_to_string(sum_t *dst, char *s)
>  {
>  	int i;
> -	char *s = alloc(CS_SIZE * 2 + 1);
>  
>  	for (i = 0; i < CS_SIZE; ++i)
>  		sprintf(s + i * 2, "%02x", dst->out[i]);
> -
> -	return s;
>  }
>  
>  int
> @@ -523,7 +521,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>  		exit(-1);
>  	}
>  
> -	d = fdopendir(dirfd);
> +	d = fdopendir(dup(dirfd));
>  	if (!d) {
>  		perror("opendir");
>  		exit(-1);
> @@ -547,6 +545,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>  		}
>  		++entries;
>  	}
> +	closedir(d);
>  	qsort(namelist, entries, sizeof(*namelist), namecmp);
>  	for (i = 0; i < entries; ++i) {
>  		struct stat64 st;
> @@ -674,21 +673,19 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>  		sum_fini(&meta);
>  		if (gen_manifest || in_manifest) {
>  			char *fn;
> -			char *m;
> -			char *c;
> +			char m[CS_STR_SIZE];
> +			char c[CS_STR_SIZE];
>  
>  			if (S_ISDIR(st.st_mode))
>  				strcat(path, "/");
>  			fn = escape(path);
> -			m = sum_to_string(&meta);
> -			c = sum_to_string(&cs);
> +			sum_to_string(&meta, m);
> +			sum_to_string(&cs, c);
>  
>  			if (gen_manifest)
>  				fprintf(out_fp, "%s %s %s\n", fn, m, c);
>  			if (in_manifest)
>  				check_manifest(fn, m, c, 0);
> -			free(c);
> -			free(m);
>  			free(fn);
>  		}
>  		sum_add_sum(dircs, &cs);
> @@ -696,6 +693,9 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>  next:
>  		free(path);
>  	}
> +	for (i = 0; i < entries; ++i)
> +		free(namelist[i]);
> +	free(namelist);
>  }
>  
>  int
> @@ -713,6 +713,7 @@ main(int argc, char *argv[])
>  	int elen;
>  	int n_flags = 0;
>  	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSnNw:r:vx:";
> +	char sum_string[CS_STR_SIZE];
>  
>  	out_fp = stdout;
>  	while ((c = getopt(argc, argv, allopts)) != EOF) {
> @@ -871,9 +872,11 @@ main(int argc, char *argv[])
>  		if (!gen_manifest)
>  			fprintf(out_fp, "%s:", flagstring);
>  
> -		fprintf(out_fp, "%s\n", sum_to_string(&cs));
> +		sum_to_string(&cs, sum_string);
> +		fprintf(out_fp, "%s\n", sum_string);
>  	} else {
> -		if (strcmp(checksum, sum_to_string(&cs)) == 0) {
> +		sum_to_string(&cs, sum_string);
> +		if (strcmp(checksum, sum_string) == 0) {
>  			printf("OK\n");
>  			exit(0);
>  		} else {
> -- 
> 2.30.0
> 

