Return-Path: <linux-erofs+bounces-696-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2901AB0D0AC
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jul 2025 05:54:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmNgW1XnZz2yF0;
	Tue, 22 Jul 2025 13:54:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::a31"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753156471;
	cv=none; b=FUIPVarncqK5NSmzE8IKQQ5xqTVCmiGtaCHIs5MO2gSZrjeWmrCEojq5/Y1Ww0F+Rj8g7tflZlSdh3YRoaqSkeqo5CnBjDU+68uA154zXICetB+bqmjekA2CvqntdatCsxA3z/ixfw6xZo630BNWsGmV+Ekt4wK0I00FiHpHs+vJ9PfTlomykebQ4frGXhbJSf2JP9Ro6RDwkk17vwhEy1yRBqEWbFDQWGYp4vAwuPPGBTR66tn6dqP1+yCe7E+MqUtvKyzThRJ0yAff9EGGSlE4vMbmtv8ZmQlYlp44/FHUA7/tkXGOo6Lf0nf3HD7wDMrPRgJkvm/BvzAFoTSX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753156471; c=relaxed/relaxed;
	bh=sAAlykKu642VPrQqfIgQ/sSqAoZceoQZhIURS8zROzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Of8SyL6oNSBKftBMzuLWAnPgcoCUCYn0jLNh9axUx5angkP7Nj84lNjD3vuMW+WSSDw0Yd/ubaO1Bxbj/SsFDnxW7VL0oO5rJKdpNycVEBVcoqBfCfLEZyVZHWs6s3AUn45QNmL7m28oB3kzHFpGcwoQBMQbiXVf/E4FIazh+EYFVu5jhN6lUE2HFrZEEoy0J/hFdOSujMQ/3xoT0dX9uhbYy9eX2Ku1X5PVpB6ZNwrBk6Q+HMT+QgJQCxOBqplEycxW9C8BCsIhEaSSRQvrFTXe7yShw0y2Xay79HLTJG72O1q38FgZSF9YOMcWSnDlmrCO4t0VkB8wLBwtk10EZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cepJpVJN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a31; helo=mail-vk1-xa31.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cepJpVJN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::a31; helo=mail-vk1-xa31.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmNgT4rCVz2xfB
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jul 2025 13:54:28 +1000 (AEST)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-5315ebfda19so1308449e0c.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 20:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753156466; x=1753761266; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAAlykKu642VPrQqfIgQ/sSqAoZceoQZhIURS8zROzA=;
        b=cepJpVJNrRWi7pOh6tHn4PMn6ON/1aWCn2IaiZtquUrwHpOBL/ajpMSr3vsrU9jTo/
         I9nmKWIEuJKMb3bsRXOtKHWnNQbrXv1MqpV9Ypo/IoPSUDiw9GY0gkTToQ3Hj9ZOqKNM
         kmK9zwO2UZoxvNDv+qFcQbB0Y5W0c9EX68b79BPlMSvRP2B240q1ktaD+QqJwf1WeX1C
         4267dTTLpQQv0rlngcKIChSZcG0TbmsXjPqsFpTPxYvnOHd7r1CVPeFb2gDLNnZC7ZaX
         Hu2YY7mkKkLka574wg//TAm8Kp6EDCtjl1gx1v6iovlu3Dls/IE7clmQFZcAQDQn6KeM
         UHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753156466; x=1753761266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAAlykKu642VPrQqfIgQ/sSqAoZceoQZhIURS8zROzA=;
        b=CZsms/GVvFr5OQj9RUJsSyJSemfsp+eFMipujh5XXoPCNwFgB/f0rSQsojMf2gwFCX
         AgJtJC3l+KzB/tSws5dRUOPAndGy6cLXl+UUxzD8SMhucWFP02CrUJcBVeVj8ZZigcDw
         COAq5DrzfJTz4ClP62p8BjwplzU5xCtaBujuiZAQu3JzpuGa16Q0RJFdHOkWopuJ70wl
         YLeDDBpB7NYQJfQqRtD+MxO1X109X4szl99dzD87Ybmj0/TE9VJOg0aPIHpo5WBSFEeZ
         NHLfDuHpS7iHDZbBY5DOOLP0dElQRG6t4pI9ok6yhfIOAyWESFkHfhhUBfQG/TJwTggV
         BRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7VuWb1R+EnPvd269EtginqRHQ8ZbADXRv5p4f+VzYldf43aQzGp3wxHyQ1btnHlSdh8RoAN8hmjhQrQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyTvdqIxtvWxS8FhyX08eo+oCa19+e9X/7Z3QFJbQJ9o59U2x/C
	7yniqHi5FFzi9teDOeIybJpNPwKLAC3ICIievXMDIPFweywgJCq0PH+Ue+ItvM4Oxdlit1vOBJq
	vlT6shV/xPQoQpUBVzoNeu7BHRXRoa/0=
X-Gm-Gg: ASbGncuqXvc5Wo1/UNlEddsSB1EUWQca3RigGPTrBSBsdo1nV5IoR8NBY98s5BPnCIs
	y8XL4lGBIfjBgXb07d+/+5ix5ym2/VtY7L4N2d3uF5epBweDMbXFYGq7VE9wnCWaRVNZPvOYeq6
	5lvselb/Ah/Yyv1Bqnb/E+zd0RYesvGX7Gt4VzVyJ0Sc5B7rLau42zULv+yRKDMs7Txv9jtObKr
	TsQsXI=
X-Google-Smtp-Source: AGHT+IFdEM3sDnKSU7djtnY2X77gIkWr33PBhDuXfdQIDGEOAUgRW6b8nyrGT5SpWkQFjiRSNtgM+8Lmi+axf63N/6M=
X-Received: by 2002:a05:6122:4d0f:b0:531:236f:1295 with SMTP id
 71dfb90a1353d-5373fbda52dmr10043238e0c.5.1753156466033; Mon, 21 Jul 2025
 20:54:26 -0700 (PDT)
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
MIME-Version: 1.0
References: <aHa8ylTh0DGEQklt@casper.infradead.org> <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com> <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
 <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com> <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
 <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
In-Reply-To: <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 22 Jul 2025 11:54:14 +0800
X-Gm-Features: Ac12FXykbYYT14P53wpCeHJw2yoMEcQU-j3E43IYKsTdPACdf43QFDrlblVigVM
Message-ID: <CAGsJ_4ySQFzSbXZzecH9oy53KFpVsoaqXThPiJxfYUJF3_Y+Hg@mail.gmail.com>
Subject: Re: Compressed files & the page cache
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>, 
	Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	Paulo Alcantara <pc@manguebit.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	Phillip Lougher <phillip@squashfs.org.uk>, Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jul 21, 2025 at 7:37=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/7/21 19:55, Jan Kara =E5=86=99=E9=81=93:
> > On Mon 21-07-25 11:14:02, Gao Xiang wrote:
> >> Hi Barry,
> >>
> >> On 2025/7/21 09:02, Barry Song wrote:
> >>> On Wed, Jul 16, 2025 at 8:28=E2=80=AFAM Gao Xiang <hsiangkao@linux.al=
ibaba.com> wrote:
> [...]
> >>> Given the difficulty of allocating large folios, it's always a good
> >>> idea to have order-0 as a fallback. While I agree with your point,
> >>> I have a slightly different perspective =E2=80=94 enabling large foli=
os for
> >>> those devices might be beneficial, but the maximum order should
> >>> remain small. I'm referring to "small" large folios.
> >>
> >> Yeah, agreed. Having a way to limit the maximum order for those small
> >> devices (rather than disabling it completely) would be helpful.  At
> >> least "small" large folios could still provide benefits when memory
> >> pressure is light.
> >
> > Well, in the page cache you can tune not only the minimum but also the
> > maximum order of a folio being allocated for each inode. Btrfs and ext4
> > already use this functionality. So in principle the functionality is th=
ere,
> > it is "just" a question of proper user interfaces or automatic logic to
> > tune this limit.
> >
> >                                                               Honza
>
> And enabling large folios doesn't mean all fs operations will grab an
> unnecessarily large folio.
>
> For buffered write, all those filesystem will only try to get folios as
> large as necessary, not overly large.
>
> This means if the user space program is always doing buffered IO in a
> power-of-two unit (and aligned offset of course), the folio size will
> match the buffer size perfectly (if we have enough memory).
>
> So for properly aligned buffered writes, large folios won't really cause
>   unnecessarily large folios, meanwhile brings all the benefits.

I don't think this captures the full picture. For example, in memory
reclamation, if any single subpage is hot, the entire large folio is
treated as hot and cannot be reclaimed. So I=E2=80=99m not convinced that
"filesystems will only try to get folios as large as necessary" is the
right policy.

Large folios are a good idea, but the lack of control over their maximum
size limits their practical applicability. When an embedded device enables
large folios and only observes performance regressions, the immediate
reaction is often to disable the feature entirely. This, in turn, harms the
adoption and development of large folios.

>
> Although I'm not familiar enough with filemap to comment on folio read
> and readahead...
>
> Thanks,
> Qu

Best Regards
Barry

