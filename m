Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75497A124B5
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 14:29:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY6K90zcCz3bh2
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 00:29:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736947739;
	cv=none; b=deml1BV86psZWyxtwFzPOTKi83o0Hajm9Ic6QCaFPebDruWE0WAoB+vVzTPhoXXoR1GHQOpbiGKRPxxo789f4onPN+V4zu6WfPFUZbJeaAUcfvAPWXgbBh66fFS6722UtQD2a3x51Sarr971Jt8ZwioTH1x7XX7X8j0GL80U2VkzWxhZDNdJnFpy4bWYdhuZK0OHEtLYU1EsBSWOtcr2bg+onocZ1/ZMef9M27dxcTL7/XcbxTGi2lKERUNZkTOmrlLO5AWkzdSjNzO+6qs8LyDigR6bGJ8d8/sdnI/I0wY+Q2gAX8xhHHboNX8YJ/utOfWvy0Ynv1xRvyjmFhDfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736947739; c=relaxed/relaxed;
	bh=Nf/bRI9F8H3DG5UlQJaQACm8ygcBNuxPnrAMW4hnfts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RA+/+UxSSOwfTvVvr94mnAEh8KkbmDutbjy+R0QbZBWRe6FvmVJG4bEK+bLS1KT7MmPC35FWrmBrvcSJ01780Ilvfcop1V+M3YmYETeTUIcw8IXrAT1h9RzHOTSBcpxAtT4ZTM6dBNyLNd4mdYu3s30Kz2YtMXEUadykQTNq1+mIEYOaCtVRv2ras+L2i6H2DGoBVToEmtWoqlTonkwSng7AaaG27elpOpitxYx+QSApZVNe6lBT4e18xiZS25MBc+dZ/TdY0RKQ9C37TyBwBjXkdhvlEL8zXFgIhPiHt7Lo4j0bS1/vwXhY1lQcwlK+tLC7vPILwyIdNolVKRwChA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GNLboc/M; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5JDLdRG; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GNLboc/M;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5JDLdRG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY6K63bPvz305Y
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 00:28:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736947730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf/bRI9F8H3DG5UlQJaQACm8ygcBNuxPnrAMW4hnfts=;
	b=GNLboc/MJh2lgPpW8vJ6UJ5QzQA0ds6PmQblZ1WPE42pdQgFZyplxeVgFcSfYBBAJGNTxV
	37NzajXjsVTWnBnUNs5N93bBTJfwqg1kjpd6eJ3knl6VmuXZY0T8RtD/JFgvFI6CUluyw8
	vNrq/Le7rKWHtKLCMVgTl92mO2duIp8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736947731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf/bRI9F8H3DG5UlQJaQACm8ygcBNuxPnrAMW4hnfts=;
	b=H5JDLdRGoGlRyqP/IVneEcdrzt4uvaGyma5Ix5eY9IW6yELSbRt2dTKrRTVaizAnfv1EHl
	cbI4cVS4gNDgNkfpD+/mt2n/IYnfJKk3McLYBjsYOhspY7rIf7PlN3K15oUR/fyyeoGrIP
	SaR6/5lAIbe/IiZU1kRQTLXLNQ2uN6A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-tVOHwevEMBqwHYxuw1MehQ-1; Wed, 15 Jan 2025 08:28:49 -0500
X-MC-Unique: tVOHwevEMBqwHYxuw1MehQ-1
X-Mimecast-MFC-AGG-ID: tVOHwevEMBqwHYxuw1MehQ
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166a1a5cc4so114021035ad.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 05:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736947728; x=1737552528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf/bRI9F8H3DG5UlQJaQACm8ygcBNuxPnrAMW4hnfts=;
        b=G538oiqzkNLxiMFgf4aU7KBXBq4ddwbhhAYWx8hK2OQ+8j4B0yngZokcYeRpsoo8GK
         CFMyH4ICGdgjzF/yQUJFLIdpX8GSUz/jBpF0LNSjczDpfObKfhhH9AiqjLvWi7lopRyE
         G1S1Kdn4BlO5priKwdZ0+AATU4GQfu2LAmlzhURMTHB9SRTm815vpoT7/kEl5CEn4y9G
         WNwqImMQ6TOFtf8cpsusfhHRY7+VYkKK8ai8cQxQJD8Wh83yp2ZiXwnE4eQlU3vS2Iyb
         MZiwQqytbyWXFidFhr55m71hKUpY5rSNHEPI3wSV0K1yb/Kh2AnCHd1lb+Ea6UM/tAju
         PYwA==
X-Forwarded-Encrypted: i=1; AJvYcCX61Vd7X+OJVO0ez4VHL1cX1syTMBUZIfM4E30x1naqwa04G5LIEb5pYh/ptJXPTjsBSVpqS/zzWsr2Aw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywt9t2FRtV4iXRnu0xOJ/sJzecdHodnCumw120XbS/Zxy0WvcQq
	Fihd3+S/1MuOFOO3bn52DnvlEQMl8VdkrkZDtausXJKlyvilQ1n4tMKSGh1poGa3nmUgiCELM/e
	lBGwO3Fbv5tK3x7+CAtpHj3eswesCk+eSichaTbBsH5/s7nOUpbVPUD8b5/dB1rkANa49bIgfVN
	xczJKjpqre4/7DM++A2Yz0gROh9DWZq9g13GnM
X-Gm-Gg: ASbGncukgpFtkYI5u9Gm1irSBP+AjlHs+wHrvKlCkJ3OVGDw9+6snMR0vdZB5TIpEnC
	SC41VzfgAuoTIXRMIuF03iMkrl28ldFV+CqYQ
X-Received: by 2002:a17:902:ea07:b0:217:9172:2ce1 with SMTP id d9443c01a7336-21a83f5db69mr480494795ad.22.1736947728096;
        Wed, 15 Jan 2025 05:28:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWkCFLrwayc2dPGspndw+hcfEp3QAcYd/bnIVRKhsGboPR86dXo/zwFq2qs4H+jDeTVaXTl/HFSSI3mVDNd2I=
X-Received: by 2002:a17:902:ea07:b0:217:9172:2ce1 with SMTP id
 d9443c01a7336-21a83f5db69mr480494425ad.22.1736947727803; Wed, 15 Jan 2025
 05:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-3-hch@lst.de>
In-Reply-To: <20250115094702.504610-3-hch@lst.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 15 Jan 2025 14:28:36 +0100
X-Gm-Features: AbW1kvY2TM4e6V0AysHtF1TdOa092YXLOMhimyjIhR1wLmk0-daNjTVYF4PhKBw
Message-ID: <CAHc6FU6OyLot1pA1dH_wd10YyVzXfOEcqa+LKFghuTpfePDEpw@mail.gmail.com>
Subject: Re: [PATCH 2/8] lockref: improve the lockref_get_not_zero description
To: Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3xHDz6qcqfCv_EBvzMHXJE13Af9b21vGtRTREBG78Tw_1736947728
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Christian Brauner <brauner@kernel.org>, LKML <linux-kernel@vger.kernel.org>, gfs2 <gfs2@lists.linux.dev>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jan 15, 2025 at 10:56=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
> lockref_put_return returns exactly -1 and not "an error" when the lockref
> is dead or locked.

The function name in the subject needs fixing.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  lib/lockref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/lockref.c b/lib/lockref.c
> index a68192c979b3..b1b042a9a6c8 100644
> --- a/lib/lockref.c
> +++ b/lib/lockref.c
> @@ -86,7 +86,7 @@ EXPORT_SYMBOL(lockref_get_not_zero);
>   * @lockref: pointer to lockref structure
>   *
>   * Decrement the reference count and return the new value.
> - * If the lockref was dead or locked, return an error.
> + * If the lockref was dead or locked, return -1.
>   */
>  int lockref_put_return(struct lockref *lockref)
>  {
> --
> 2.45.2

Thanks,
Andreas

