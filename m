Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4676680F905
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 22:18:27 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cg4M+oo5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cg4M+oo5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SqWgN5CNlz3bTn
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Dec 2023 08:18:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cg4M+oo5;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cg4M+oo5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=ecurtin@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SqWgC5ybWz2ykZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Dec 2023 08:18:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702415889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0WO36JLXIv5AaAr7yVxA4KjLJZuBfSjRiR5T6MWPYU=;
	b=Cg4M+oo5St/YzM0hIx8Mx6CIpuDTebAXspCV1MaMeB0e/zfXvPGMb2OsKNKx1EuVpwzGiE
	LKhVwSdueKf6qbccrvjtm/iPy5ZqgCGJDp2UJPLdEc8GDic3VgogdSnHUyQ0RYuCzZeEAR
	1S6k2qMdabU5xF+dYKAkPfmNZZx7V7s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702415889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0WO36JLXIv5AaAr7yVxA4KjLJZuBfSjRiR5T6MWPYU=;
	b=Cg4M+oo5St/YzM0hIx8Mx6CIpuDTebAXspCV1MaMeB0e/zfXvPGMb2OsKNKx1EuVpwzGiE
	LKhVwSdueKf6qbccrvjtm/iPy5ZqgCGJDp2UJPLdEc8GDic3VgogdSnHUyQ0RYuCzZeEAR
	1S6k2qMdabU5xF+dYKAkPfmNZZx7V7s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-EzCD-BOrOBKN1O4e6pFqCg-1; Tue, 12 Dec 2023 16:18:07 -0500
X-MC-Unique: EzCD-BOrOBKN1O4e6pFqCg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c668b87db3so2829825a12.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 13:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702415886; x=1703020686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0WO36JLXIv5AaAr7yVxA4KjLJZuBfSjRiR5T6MWPYU=;
        b=ZwJXNAgQljtRYuyWklG7hPDHhq0fWFh7idA4L634QCbSSEdLaOZLjNxkwSOHt6Y/Wx
         nRvfHuk0ctGf32edWhomVYbZmcYAwfGAaCbP7z1meb6L+M4kBS02NrJsfOZN7qlaBqgT
         fnmxlXEf1mbNn7NCilP1ch4A4hx4pGFjVe0/pJR45AkLy7iLQOR87CNXrtExiceHcRSP
         dltTDX0GGLdk2LeItoDS1HFOzXxxTRmPpbIK28boNbmfTz+ucfS6BhuNjdqKiZ+a/WEu
         cAjMX61ySaD6bCm3SbZRRj1IS4qMeB4cvlbIsDNxBtanqcZP59ViqLUrsxeMHkwLEnrO
         noKw==
X-Gm-Message-State: AOJu0YyzYMb2SjABlPFcXZEOd+Lj+vPt2hSqZeMfGI1eDho4CZZ2njIo
	oHyRdJ0JIiTISlx0XNAbuhlH3rddmaZd9/5984DazYxzVKfrkUfbSGivjmPusK0snUQgUeLYmtk
	wK9lmnc+nQ1i03kmjhFBCTIfF7LOhj4WTyzld47Ro
X-Received: by 2002:a05:6a21:a5a4:b0:18f:fcc5:4c4f with SMTP id gd36-20020a056a21a5a400b0018ffcc54c4fmr3324485pzc.40.1702415886583;
        Tue, 12 Dec 2023 13:18:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaBUhsIKPiauenUWhA450tnBxmPri38tJ3FEk9h3f5UdGgkVU3xuISSVrM65CvHBeTYR1IOqNO0hPKmoRXyW0=
X-Received: by 2002:a05:6a21:a5a4:b0:18f:fcc5:4c4f with SMTP id
 gd36-20020a056a21a5a400b0018ffcc54c4fmr3324464pzc.40.1702415886268; Tue, 12
 Dec 2023 13:18:06 -0800 (PST)
MIME-Version: 1.0
References: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
 <941aff31-6aa4-4c37-bb94-547c46250304@linux.alibaba.com> <ZXgNQ85PdUKrQU1j@infradead.org>
 <58d175f8-a06e-4b00-95fe-1bd5a79106df@linux.alibaba.com> <ZXha1IxzRfhsRNOu@infradead.org>
In-Reply-To: <ZXha1IxzRfhsRNOu@infradead.org>
From: Eric Curtin <ecurtin@redhat.com>
Date: Tue, 12 Dec 2023 21:17:29 +0000
Message-ID: <CAOgh=Fw2TcOFgCz1HbU1E=_HGRnf1PTTG2Qp_nD1D9f083RwUA@mail.gmail.com>
Subject: Re: [RFC KERNEL] initoverlayfs - a scalable initial filesystem
To: Christoph Hellwig <hch@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: nvdimm@lists.linux.dev, Colin Walters <walters@redhat.com>, Lokesh Mandvekar <lmandvek@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>, Yariv Rachmani <yrachman@redhat.com>, Brian Masney <bmasney@redhat.com>, Daniel Walsh <dwalsh@redhat.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-unionfs@vger.kernel.org, Pavol Brilla <pbrilla@redhat.com>, Eric Chanudet <echanude@redhat.com>, Alexander Larsson <alexl@redhat.com>, Lennart Poettering <lennart@poettering.net>, Gao Xiang <hsiangkao@linux.alibaba.com>, Neal Gompa <neal@gompa.dev>, linux-erofs@lists.ozlabs.org, Douglas Landgraf <dlandgra@redhat.com>, Luca Boccassi <bluca@debian.org>, =?UTF-8?B?UGV0ciDFoGFiYXRh?= <psabata@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 12 Dec 2023 at 13:06, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Dec 12, 2023 at 03:50:25PM +0800, Gao Xiang wrote:
> > I have no idea how it's faster than the current initramfs or initrd.
> > So if it's really useful, maybe some numbers can be posted first
> > with the current `memmap` hack and see it's worth going further with
> > some new infrastructure like initdax.
>
> Agreed.
>

I was politely poked this morning to highlight the graphs on the
initoverlayfs page, so as promised highlighting. That's not to say
this is either kernelspace's or userspace's role to optimize, but it
does prove there are benefits if we put some effort into optimizing
early boot.

https://github.com/containers/initoverlayfs

With this approach systemd starts ~300ms faster on a Raspberry Pi 4
with sd card, and this systemd instance has access to all the files
that a traditional initramfs would. I did this test on a Raspberry Pi
4 with NVMe drive over USB and the results were closer to a 500ms
benefit in systemd start time.

Is mise le meas/Regards,

Eric Curtin

