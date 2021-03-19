Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ADF341413
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Mar 2021 05:16:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F1rF91PmHz3bsq
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Mar 2021 15:16:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RgffCLKX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RgffCLKX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=RgffCLKX; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RgffCLKX; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F1rF60swZz30CW
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Mar 2021 15:16:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616127396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fhkm3I7YJkrB4vQzfYOVqceaFTpMmkPj/a4yOIpQi6U=;
 b=RgffCLKXYXGQwoLW98ngj0qoDpBWUuVZDBNv710tH2j2f0dPZiGB2w2agqm2rhfzJokFK+
 USN0zobFkeXSAF+QVUlHSBEB6ID5LoTDFSMqrW5jklQIbfE0p1aBrN3NiKmwUoGwUBKj4Y
 hIKel+4B+sKikikj9yAwo9MRS0q0/28=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616127396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fhkm3I7YJkrB4vQzfYOVqceaFTpMmkPj/a4yOIpQi6U=;
 b=RgffCLKXYXGQwoLW98ngj0qoDpBWUuVZDBNv710tH2j2f0dPZiGB2w2agqm2rhfzJokFK+
 USN0zobFkeXSAF+QVUlHSBEB6ID5LoTDFSMqrW5jklQIbfE0p1aBrN3NiKmwUoGwUBKj4Y
 hIKel+4B+sKikikj9yAwo9MRS0q0/28=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-VM2dASl7O_mFIoBRKwRFTw-1; Fri, 19 Mar 2021 00:16:33 -0400
X-MC-Unique: VM2dASl7O_mFIoBRKwRFTw-1
Received: by mail-pg1-f197.google.com with SMTP id b20so880896pgs.4
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Mar 2021 21:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Fhkm3I7YJkrB4vQzfYOVqceaFTpMmkPj/a4yOIpQi6U=;
 b=CbHjgfKiAkMGzbN6Rnv4L3Oeo6pIksehlWNTo4DlacGlC+cy2WhjKrk4CI6cwbqFn4
 cjT7tWqg+tuhLxxaj9i2QjV9ri/thln61USSRiGoZPGQHqFUxkkC07VsL861JPNgeqOo
 3hrB14k1Zp88iIzPIvrBqaPnDlkfKya4QE9YXi0bbXaF5l//1VuywM5y1oVgcAQEiOl0
 QAB8UjPYke1aVxipeT+zSPiEKQvviv7kFLbctHeA1HZKzrKLGoEZwBP+2M/1Jdef9SDH
 GFyUAIj+UCd5bzVaXNdZzfIKLYBt6jA24mo2s3//C+WNoHqr5X1up0xiQr8Rr8u4f+z2
 EbqA==
X-Gm-Message-State: AOAM531kWilmF+r0HrwIfqTjS9sj0RqYPGrGKDnt/6Ydh+nyC4t2bjaU
 hK22SojAjf7kGXBpMfGTeYbaS+HBIWFPF6odXOGUa986Jwa6RTWwkg9LMIGmitUMYNJYrw5BQ9D
 p4BDqBfTpnSpNMNgFPNJ4huzj
X-Received: by 2002:a17:90a:5284:: with SMTP id
 w4mr7561398pjh.29.1616127392283; 
 Thu, 18 Mar 2021 21:16:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6yU8WKXeC//FEBmjUB4/v+p+sRLJt6wM50P29v0rcFSpGwIdiUxrwif9mSFPQyLZbSwodGQ==
X-Received: by 2002:a17:90a:5284:: with SMTP id
 w4mr7561382pjh.29.1616127391987; 
 Thu, 18 Mar 2021 21:16:31 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g21sm3855236pfk.30.2021.03.18.21.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 21:16:31 -0700 (PDT)
Date: Fri, 19 Mar 2021 12:16:21 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] erofs: fix bio->bi_max_vecs behavior change
Message-ID: <20210319041621.GB1431129@xiangao.remote.csb>
References: <20210306033109.28466-1-hsiangkao@aol.com>
 <20210306040438.8084-1-hsiangkao@aol.com>
 <dffa941d-63b5-2068-80f4-dd012f520147@huawei.com>
MIME-Version: 1.0
In-Reply-To: <dffa941d-63b5-2068-80f4-dd012f520147@huawei.com>
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
Cc: Martin DEVERA <devik@eaxlabs.cz>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Fri, Mar 19, 2021 at 10:15:18AM +0800, Chao Yu wrote:
> On 2021/3/6 12:04, Gao Xiang wrote:

...

> > +	    (*last_block + 1 != current_block || !*eblks)) {
> 
> Xiang,
> 
> I found below function during checking bi_max_vecs usage in f2fs:
> 
> /**
>  * bio_full - check if the bio is full
>  * @bio:        bio to check
>  * @len:        length of one segment to be added
>  *
>  * Return true if @bio is full and one segment with @len bytes can't be
>  * added to the bio, otherwise return false
>  */
> static inline bool bio_full(struct bio *bio, unsigned len)
> {
>         if (bio->bi_vcnt >= bio->bi_max_vecs)
>                 return true;
> 
>         if (bio->bi_iter.bi_size > UINT_MAX - len)
>                 return true;
> 
>         return false;
> }
> 
> Could you please check that whether it will be better to use bio_full()
> rather than using left-space-in-bio maintained by erofs itself? something
> like:
> 
> if (bio && (bio_full(bio, PAGE_SIZE) ||
> 	/* not continuous */
> 	(*last_block + 1 != current_block))
> 
> I'm thinking we need to decouple bio detail implementation as much as
> possible, to avoid regression whenever bio used/max size definition
> updates, though I've no idea how to fix f2fs case.

Thanks for your suggestion.

Not quite sure I understand the idea... The original problem was that
when EROFS bio_alloc, the number of requested bvec also partially stood
for remaining blocks of the current on-disk extent to limit the read
length. but after that bio behavior change, bi_max_vec could be increased
internally by block layer (e.g. 1 --> 4), so bi_max_vecs is no longer
as what we expect (I mean passed-in). so could cause read request
out-of-bound or hung. That's why I decided to record it manually (never
rely on bio statistics anymore...)

Also btw, AFAIK, Jianan is still investigating to use iomap instead
(mainly resolve tail-packing inline path). And I'm also busy in big
pcluster and LZMA new features for the next cycle. So I think we might
leave it just as is and it would be replaced with iomap in the future.

Thanks,
Gao Xiang

> 
> Let me know if you have other concern.
> 
> Thanks,

