Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5006B213E
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 11:21:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXQGB4tcpz3cMc
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 21:21:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zs37hMZA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zs37hMZA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zs37hMZA;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zs37hMZA;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXQG50CYlz3bgn
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Mar 2023 21:21:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678357303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ir/h645vG7/3e7LKCiTYw/Yo812wpfTRDoEn9ipx+Q=;
	b=Zs37hMZAnLpmF3UA7V3U8UKxaQGvUdMSJhJB3plbIKIjBk7rdl8OMJuWHK/mfqvjGN0xCi
	FhZDmBmSG0F9FtSXT7T2QTj4wstfEANj5w6oa4Q6TfdQLBeBCng2/hyuHBrpr8EY0aSId5
	FRcX8y5Fwl1jC5ehzfHv/pOrnJ8+a0Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678357303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ir/h645vG7/3e7LKCiTYw/Yo812wpfTRDoEn9ipx+Q=;
	b=Zs37hMZAnLpmF3UA7V3U8UKxaQGvUdMSJhJB3plbIKIjBk7rdl8OMJuWHK/mfqvjGN0xCi
	FhZDmBmSG0F9FtSXT7T2QTj4wstfEANj5w6oa4Q6TfdQLBeBCng2/hyuHBrpr8EY0aSId5
	FRcX8y5Fwl1jC5ehzfHv/pOrnJ8+a0Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-sqMIvlERO4eH4c7Vefz5lg-1; Thu, 09 Mar 2023 05:21:41 -0500
X-MC-Unique: sqMIvlERO4eH4c7Vefz5lg-1
Received: by mail-pj1-f72.google.com with SMTP id v15-20020a17090a458f00b0023816b2f381so960047pjg.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Mar 2023 02:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678357295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ir/h645vG7/3e7LKCiTYw/Yo812wpfTRDoEn9ipx+Q=;
        b=Duftz7RX41GUu9Z2X92oRvbbN9RR8TsU+jBYZMMa1+TKyvQfyujHyeOFGJVa/UPOOG
         nceMVqBDTrFAHPEKDzqMEEObvcNejHh4UMW06r2JFJ35UemTB7QaIQ1D8BgLes3yg7He
         632EO9UVKJ9UBtskWgkp45/8i/dBmJnsKHu0E/b3wzQS2nDJvCrSD9Px2iKb9uNCz+9b
         iMdMUitkx9yY9CPGKIApGOvCQWTVTqczOfA/h1ARWYk6rlBtjVSNYtMJmbbvvd4LKK+V
         nyE90GvhdPq5AkQBoEltAjElrPEcO4qC5H9lrS3xytyKhbK+H22/qIodr7wADzFGm6D1
         Ubhw==
X-Gm-Message-State: AO0yUKXmKlc10/Q1jhSoShtl+UWodTPvj7VhCqWG5RJznxyteQd1eTJ+
	RHC0mG2ZE5k50GJFt7zXq5xP6vgREZVzV9P1Y5KYkcNRucrrKOQJfK8maLHnfTYu2pLUzIac8sY
	jwHNEoRFcoTzcnXVBI2aVTm9xcScgzuqry0gvuzlN
X-Received: by 2002:a17:902:f7c1:b0:19c:a3be:a4f3 with SMTP id h1-20020a170902f7c100b0019ca3bea4f3mr8229339plw.4.1678357295500;
        Thu, 09 Mar 2023 02:21:35 -0800 (PST)
X-Google-Smtp-Source: AK7set9VDTf99mRyC2eJOBxIkMspHxJ2pV++2lzfcL1yIkpa4x+m9xdxgNtT/wUdeXHjX/qKTQaaMK9Wp7kJK/Zrno4=
X-Received: by 2002:a17:902:f7c1:b0:19c:a3be:a4f3 with SMTP id
 h1-20020a170902f7c100b0019ca3bea4f3mr8229321plw.4.1678357295164; Thu, 09 Mar
 2023 02:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20230309094317.69773-1-frank.li@vivo.com>
In-Reply-To: <20230309094317.69773-1-frank.li@vivo.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 9 Mar 2023 11:21:23 +0100
Message-ID: <CAHc6FU7vGD9NGn0phJsLEmcU8O7AaBS+hm=AEwYOc0nFGHS-hQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs: add i_blocksize_mask()
To: Yangtao Li <frank.li@vivo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: brauner@kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org, cluster-devel@redhat.com, rpeterso@redhat.com, huyue2@coolpad.com, adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Mar 9, 2023 at 10:43=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wrot=
e:
> Introduce i_blocksize_mask() to simplify code, which replace
> (i_blocksize(node) - 1). Like done in commit
> 93407472a21b("fs: add i_blocksize()").

I would call this i_blockmask().

Note that it could be used in ocfs2_is_io_unaligned() as well.

>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  include/linux/fs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c85916e9f7db..db335bd9c256 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -711,6 +711,11 @@ static inline unsigned int i_blocksize(const struct =
inode *node)
>         return (1 << node->i_blkbits);
>  }
>
> +static inline unsigned int i_blocksize_mask(const struct inode *node)
> +{
> +       return i_blocksize(node) - 1;
> +}
> +
>  static inline int inode_unhashed(struct inode *inode)
>  {
>         return hlist_unhashed(&inode->i_hash);
> --
> 2.25.1
>

Thanks,
Andreas

