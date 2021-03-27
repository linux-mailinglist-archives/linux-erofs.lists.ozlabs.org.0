Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A134B603
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 11:16:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6vrD43q5z30DL
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 21:16:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fPlshDRl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RXyxYYtn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=fPlshDRl; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RXyxYYtn; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6vrB0qfZz2yRP
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 21:16:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616840162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XiLEqXCFPEAWMY3th6jHveSdHiLHcT6jJyaqLgZfeqA=;
 b=fPlshDRlx/14Sad5WS1gyd4sOuMh5RHSfeqplWL/teT1NcpA09Sn59qRR+xe0LR1ieR35a
 CzkK8lFGxPWFkp6ntzqOt2k4MFzdkvmd9VgplYlWBdSL3kkW5yHMMdmyyUPegcOtKnEpi7
 8wU1Wv6WMeHFFSH9UzjTReZeLSrxZQE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616840163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XiLEqXCFPEAWMY3th6jHveSdHiLHcT6jJyaqLgZfeqA=;
 b=RXyxYYtn6fCcdjOUcAElbJaKuJ/9q9LItCipZu/VeXzGQ1LNoQwIzGMvW/yPUnoS4mSdfl
 WGWpDqAeDnaWr1jtQPpEYKLVbD7scAIIEXBzIzrz5hZhARYF8icC20MmVLIMCkCwKc/2K5
 unGD9GNXGZt9NUMebGkjQmyTea4q9Kw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-Hsy0spq9NRCotlJrApnhcg-1; Sat, 27 Mar 2021 06:16:00 -0400
X-MC-Unique: Hsy0spq9NRCotlJrApnhcg-1
Received: by mail-pj1-f72.google.com with SMTP id e15so8018875pjg.6
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 03:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XiLEqXCFPEAWMY3th6jHveSdHiLHcT6jJyaqLgZfeqA=;
 b=odkF1vIa9Tmqt7QNbRuxEsLxxR7hi9z1CE7HchSzfalEFcCjjRnbjaEoHf+fZkNRA9
 DGM5phrajAiBAiyJW5LPVJFbSNzQiFfrU/Dv+JpJ0XgfssDB/Z15K86nO/OnMsUX5c7G
 2kwnaASRCrshgqYzK1FyN4i5lvV3bqjsLPMphlnuhKL6RDVTmvYgsx8vKz6XZmEdVS1R
 iixXUZBgxu9Jq1mm682uk0XeLAOCSv6Mzrs25YbI2ccrKmcoNwWZomV9yuaheDXEwRg5
 m+RfkhXZUqNMNhLIFXRdBJDx2CfDO75fX0PaDZCB5naEAQek874043G2cgd2N42Zg1y8
 bbBg==
X-Gm-Message-State: AOAM532CpTtBiDChlMbfeceR9KchZQz/IW5rtWv7iwgA4ITSOh7+OwnO
 2Vrc5am9Q6ysRS5mhmp9SluJ1iTPC4lE+RUu+jmKxSIvNBO+cRl0uyVOUo6WOeO9LUzwxUqF5ad
 4YIJ0j6BiFZx90yEZXhU8dZCt
X-Received: by 2002:a17:90a:6906:: with SMTP id
 r6mr18138217pjj.235.1616840159276; 
 Sat, 27 Mar 2021 03:15:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0Hubov0I5CSfmFudM/r6ja59v9BcyPbQzN0J8z4Ny6nzZs996BKTtivIRigL6k31kOIGARA==
X-Received: by 2002:a17:90a:6906:: with SMTP id
 r6mr18138194pjj.235.1616840159080; 
 Sat, 27 Mar 2021 03:15:59 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p1sm11465128pfn.22.2021.03.27.03.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Mar 2021 03:15:58 -0700 (PDT)
Date: Sat, 27 Mar 2021 18:15:48 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/4] erofs: support adjust lz4 history window size
Message-ID: <20210327101548.GB2995728@xiangao.remote.csb>
References: <20210327034936.12537-1-hsiangkao@aol.com>
 <20210327034936.12537-3-hsiangkao@aol.com>
 <8169edfd-de1d-e2de-4805-c7e3ce8d7502@huawei.com>
MIME-Version: 1.0
In-Reply-To: <8169edfd-de1d-e2de-4805-c7e3ce8d7502@huawei.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Guo Weichao <guoweichao@oppo.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Sat, Mar 27, 2021 at 05:34:33PM +0800, Chao Yu wrote:
> On 2021/3/27 11:49, Gao Xiang wrote:
> > From: Huang Jianan <huangjianan@oppo.com>
> > 
> > lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
> > using rolling decompression, a block with a higher compression
> > ratio will cause a larger memory allocation (up to 64k). It may
> > cause a large resource burden in extreme cases on devices with
> > small memory and a large number of concurrent IOs. So appropriately
> > reducing this value can improve performance.
> > 
> > Decreasing this value will reduce the compression ratio (except
> > when input_size <LZ4_DISTANCE_MAX). But considering that erofs
> > currently only supports 4k output, reducing this value will not
> > significantly reduce the compression benefits.
> > 
> > The maximum value of LZ4_DISTANCE_MAX defined by lz4 is 64k, and
> > we can only reduce this value. For the old kernel, it just can't
> > reduce the memory allocation during rolling decompression without
> > affecting the decompression result.
> > 
> > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> > [ Gao Xiang: introduce struct erofs_sb_lz4_info for configurations. ]
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > ---
> >   fs/erofs/decompressor.c | 21 +++++++++++++++++----
> >   fs/erofs/erofs_fs.h     |  3 ++-
> >   fs/erofs/internal.h     | 19 +++++++++++++++++++
> >   fs/erofs/super.c        |  4 +++-
> >   4 files changed, 41 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index 80e8871aef71..93411e9df9b6 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -28,6 +28,17 @@ struct z_erofs_decompressor {
> >   	char *name;
> >   };
> > +int z_erofs_load_lz4_config(struct super_block *sb,
> > +			    struct erofs_super_block *dsb)
> > +{
> > +	u16 distance = le16_to_cpu(dsb->lz4_max_distance);
> > +
> > +	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
> > +					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
> > +					LZ4_MAX_DISTANCE_PAGES;
> > +	return 0;
> > +}
> > +
> >   static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
> >   					 struct list_head *pagepool)
> >   {
> > @@ -36,6 +47,8 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
> >   	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
> >   	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
> >   					   BITS_PER_LONG)] = { 0 };
> > +	unsigned int lz4_max_distance_pages =
> > +				EROFS_SB(rq->sb)->lz4.max_distance_pages;
> >   	void *kaddr = NULL;
> >   	unsigned int i, j, top;
> > @@ -44,14 +57,14 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
> >   		struct page *const page = rq->out[i];
> >   		struct page *victim;
> > -		if (j >= LZ4_MAX_DISTANCE_PAGES)
> > +		if (j >= lz4_max_distance_pages)
> >   			j = 0;
> >   		/* 'valid' bounced can only be tested after a complete round */
> >   		if (test_bit(j, bounced)) {
> > -			DBG_BUGON(i < LZ4_MAX_DISTANCE_PAGES);
> > -			DBG_BUGON(top >= LZ4_MAX_DISTANCE_PAGES);
> > -			availables[top++] = rq->out[i - LZ4_MAX_DISTANCE_PAGES];
> > +			DBG_BUGON(i < lz4_max_distance_pages);
> > +			DBG_BUGON(top >= lz4_max_distance_pages);
> > +			availables[top++] = rq->out[i - lz4_max_distance_pages];
> >   		}
> >   		if (page) {
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > index 9ad1615f4474..b27d0e4e4ab5 100644
> > --- a/fs/erofs/erofs_fs.h
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -39,7 +39,8 @@ struct erofs_super_block {
> >   	__u8 uuid[16];          /* 128-bit uuid for volume */
> >   	__u8 volume_name[16];   /* volume name */
> >   	__le32 feature_incompat;
> > -	__u8 reserved2[44];
> > +	__le16 lz4_max_distance;
> 
> It missed to add comments, otherwise it looks good to me.
>

Yes, it needs some inline comment description, will update in
the next version.

> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 

Thanks for the review!

Thanks,
Gao Xiang

> Thanks,
> 

