Return-Path: <linux-erofs+bounces-3383-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A7fKL2d/WmwgQAAu9opvQ
	(envelope-from <linux-erofs+bounces-3383-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 08 May 2026 10:24:29 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A174F3ACA
	for <lists+linux-erofs@lfdr.de>; Fri, 08 May 2026 10:24:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBhx55yPxz2xdb;
	Fri, 08 May 2026 18:24:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e29" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778228665;
	cv=pass; b=GGlFcJqvs/XEcwr+2Ot6UDPQVaQV/ABZ3R6eIM9ViUkdo7JeZ9hS97S6eWUO2rTiKdzbn00us3M4PlUBOOrg67SHwLM3B2DiHWhVG85V81jU6OHaNfTRfmkBLKNtuXr/VTuq3YoSFUepGEpxGAluWmvKc2cV4okbamXLIbwN9T6lruv61fI/8DyHCC+HeDOFnuKoJXWPoPSrtLPMpGKOftejTLHIrH/UpGQsoar67gn87F817asjVQVOnfF9YOQqnKWTSC+utMi22FPqNYxXWLktlHiliOQGanxTQSwOCxCqnKKM9gN3Plm0Xa2mscgow56by1wiMIjwOc1SxMXw2Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778228665; c=relaxed/relaxed;
	bh=tayS6wysJLp8rMyt6B+KWyRAmJJEslWhObbqyYTLCTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltrm7OfV29ykg/ZT92LP+f2gft0vctCRBeRqAlLkRBfUDQLlxiwCI94wB6VFTP1qIUqXlhkkhHAhqFqdHs33y/nAbeCsYKjiQoaPllEYJbeelNnjjieA6vQdbBBTJqylT9JV3zI4L8ALbkriNeF5K6C1uUUBMMPxPbSiigeZcP20uzAiNo3WVsv0tNf6cnbren6IQ+C2wNWazTc8YRzwggcr395BMlUjhRqyiaDGTMsNIS+OSHVeAEb1LQuuZptroXxNSBXOEwy9pL8ZN7Ofyo1OTaKd7oNKoU7XG9dYXoU+hp6mQyEKvb/jMw9mcqGD//TkweHO7TSHhD9rkDkEJQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CysznALn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e29; helo=mail-vs1-xe29.google.com; envelope-from=ishitatsuyuki@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CysznALn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::e29; helo=mail-vs1-xe29.google.com; envelope-from=ishitatsuyuki@google.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBhx42CLJz2x9N
	for <linux-erofs@lists.ozlabs.org>; Fri, 08 May 2026 18:24:23 +1000 (AEST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-63129bf2af0so481343137.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 08 May 2026 01:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778228661; cv=none;
        d=google.com; s=arc-20240605;
        b=doPPOImgCwBND+x7VxcsT2dpHVIRCtC7Ausroecxcxk0XXMhfBDbMX47x4b4QgOMhn
         jV4QW9te9oHYxm4YvZBX4IoODmjozW48UIxbaLhKW2bNresEEjkgre4nBbK3rHI9/g1u
         DwcPir0XWaXoHpf6HMC8BH41PZvW25KU90Sfwrct8Q0A06NepBjF+d1f2yIfL4vPzNsZ
         2TOh3kec3du1N/Bj9KkCy2Fc0CzPo65n8qHXVbmrNBmLyqijct8aUOYVfhIlGwb35biC
         V2OjNw0dubdObdsfzX4jlRM1Bzu2GTzie5Kyl7hW97Z3XLYe5rvCUUUQlWunkwqCY5A1
         jrsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tayS6wysJLp8rMyt6B+KWyRAmJJEslWhObbqyYTLCTo=;
        fh=kTY0zoEHlbWAxeSkzgOjvB+LJHobsjg+n6ZLYSImKvY=;
        b=NMt6Uhz9//GCXlLF8EI5DGpGBT8A5fD+oun++h0hM2eeyAfEL4FdFUyR93/A23wmSG
         xAdMwMCVfKz6IVDatPAunq96Xz/tNA7TrMfB6uZPlGRV4gNgj+K/8JRuUqYbO1rdyLua
         TWroZRMJJXu6AUuVZZDi8vsmAULiXxTyrnWdDNwvKGI/R50DcovmdlQcaDqzD4o4tcC7
         TOo/jFOPgPd6mZOCfX8UvSYSd08BKLUTJmkUIaVPibpNu/yuZsyv91nxQRPs41vplptJ
         10O9B0qwoeKb/9pXS8J3iWYqkMP/3rZd6gWNydKK+xsDOQ1nWBCkJAWdYo8JrfCxc25F
         UH6A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778228661; x=1778833461; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tayS6wysJLp8rMyt6B+KWyRAmJJEslWhObbqyYTLCTo=;
        b=CysznALnRBVSgmnQqBBanQYJI6HX7irP7PyKBAf3zcw3df2XLGkkRGEIZax/UWRgwa
         u7gNPg9kJ5vpcMgB72XGGK4XccuzsmJdf8vv01jN/ZFbIs4JoAG7N/nB+uLxjIT8efSK
         qGTxInteXtSrOT64dTQElYFuolVjOJd34cvENVXFCPW41ldGhZYj4OrZoDF2vxDZpGx7
         PzllHdj8XNZhhFrQgJAD+1lZxvvrbKzAnLdhTTb6t7BJAAgCGGoREeV9XYs+YJfNj98d
         ngP52Mou5/GCNIasM0EX7GhSPn7ODV7ygt/19llPpB7v92zRjpo11DZNufvgi6QoJqu9
         lI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228661; x=1778833461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tayS6wysJLp8rMyt6B+KWyRAmJJEslWhObbqyYTLCTo=;
        b=V+6iUcm9nvdyQbZ+bNrcQiAvtCTFqEXkqHGnU+VvDVkitZ0EyksXSfi+kbo3zx7ggr
         yE5mN1EbGzX0M7fxoe7wqj+tNSgOf6pFhJ0qHoQbDQSy6h6Yy9rvTgpTQzuXbpCC4i/7
         7XDOq9sGHiZ3sZvuTUQZ0IJe5yXiO5hzLj/zSaInawdm4+6mvhXVp9TS14gYOXJ3O+sO
         NQonBWrPx+ZSv/umejOJEIbTQzqoHA7SXtkFbckl1QQcQZ9CdG8f5hLVJHItNvTankAX
         y9pb2ht2ji1DQjR4t62UjEeDUSETgIPUULSrYRE25eUJR2yUL7/HueCvrm2MY3iBgQYm
         gQuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RPiiQHssjwYWpOnBpjndu8KB4PAuadqRR46x5TUBwmA60n/fnRWnVX7WRzyXlgfW9Nqlyi6BfJhNDjQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy4RMABnC5m0V+ppLWUrHbszFFhnseGTcZ/q0KRnQixPorxf6uA
	U2cTlbCK0Q2k/QQ54TmjCSkcqr4OSkqVX6n7gZvIxohDk2YbKoxwB8qv1T5GrhQjML6ZgH6t3qN
	kP8Mbpsw6rVAn7xVVpV9oxgLqi7P0ss7qwXuahHZ6
X-Gm-Gg: Acq92OHcfcEjIRM1kUPZrqThiygt0PeO1PM5qWZQBHRvwGJHDrkj0YW8V4t1OjjJQIL
	XC17CU7hNGVTzOos6SjVjW1nlb1XGy0jC57WBRCYLRs/wOdJFNnAAZjgMRmR/64a6pf//brxtfx
	WhSfz/ozqh5zFoM2RJNs+DrP0kKnnlYG7WbCrR8pJnJmZI8oK+VxuGFTWr5AVMRmdHRwVUBcvNT
	VkGXH6h6+Ocl8aRd43Xz+5sfLgZqXfuPdBXlKhe0wRkjn2bceMO4o5iy260+aYvIJbr0Ap6Ofwt
	AxY7nyjb1Jve1ClyS21vtQTnfYGQk5muGrV9FBizhnvAye59vbUkh4j7l11MJ68Td7f6BUVoL1E
	qB+hs4DlKb8QmVIyYjsKsZ1axNd7wAW+V
X-Received: by 2002:a05:6102:4189:b0:631:487a:238f with SMTP id
 ada2fe7eead31-631487a27ffmr110076137.4.1778228660520; Fri, 08 May 2026
 01:24:20 -0700 (PDT)
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
References: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com> <af2c4X1YCB7NEb8p@infradead.org>
In-Reply-To: <af2c4X1YCB7NEb8p@infradead.org>
From: Tatsuyuki Ishi <ishitatsuyuki@google.com>
Date: Fri, 8 May 2026 17:24:09 +0900
X-Gm-Features: AVHnY4L7ZGUcqYj7HTFkqXbk-2QOulPEhY0WgePNFm1wNC8hovnNld1FjhtmRAM
Message-ID: <CABqzrSOaCMPD_QrSq_y_6bXLC3ecm3FZsE_ACrdNbTHG8baMCw@mail.gmail.com>
Subject: Re: [PATCH] erofs: use the opener's credential when verifing metadata accesses
To: Christoph Hellwig <hch@infradead.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, 
	Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	oliver.yang@linux.alibaba.com, Carlos Llamas <cmllamas@google.com>, 
	Sandeep Dhavale <dhavale@google.com>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000a4bfc106514a1f64"
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: C3A174F3ACA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3383-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:cmllamas@google.com,m:dhavale@google.com,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ishitatsuyuki@google.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ishitatsuyuki@google.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

--000000000000a4bfc106514a1f64
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 5:20=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:

> On Tue, May 05, 2026 at 11:56:15PM +0800, Gao Xiang wrote:
> > Similar to commit 905eeb2b7c33 ("erofs: impersonate the opener's
> > credentials when accessing backing file"), rw_verify_area() needs
> > the same too.
>
> Two things here:
>
>  - rw_verify_area is a helper for use inside the VFS and file system
>    read/write method implementation.  Erofs as a user of the VFS should
>    not use it at all.
>  - using the opener credentials when accessing the backing file seems
>    wrong.  The entity accessing it is the file system, so it should
>    have system or mounter credentials, not that of someone causing
>    metadata / fs data access.  And this applies to all access by
>    a file system backed by a backing file.
>

I think there's probably some confusion of terminology here. buf->file is
opened with the mounter's credentials, so we are impersonating the mounter
here. Perhaps the commit message could describe that more clearly. Same for
the previous patches mentioned.

--000000000000a4bfc106514a1f64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, May 8, 2026 at 5:20=E2=80=AFPM Ch=
ristoph Hellwig &lt;<a href=3D"mailto:hch@infradead.org">hch@infradead.org<=
/a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Tue, May 05, 2026 at 11:56:1=
5PM +0800, Gao Xiang wrote:<br>
&gt; Similar to commit 905eeb2b7c33 (&quot;erofs: impersonate the opener&#3=
9;s<br>
&gt; credentials when accessing backing file&quot;), rw_verify_area() needs=
<br>
&gt; the same too.<br>
<br>
Two things here:<br>
<br>
=C2=A0- rw_verify_area is a helper for use inside the VFS and file system<b=
r>
=C2=A0 =C2=A0read/write method implementation.=C2=A0 Erofs as a user of the=
 VFS should<br>
=C2=A0 =C2=A0not use it at all.<br>
=C2=A0- using the opener credentials when accessing the backing file seems<=
br>
=C2=A0 =C2=A0wrong.=C2=A0 The entity accessing it is the file system, so it=
 should<br>
=C2=A0 =C2=A0have system or mounter credentials, not that of someone causin=
g<br>
=C2=A0 =C2=A0metadata / fs data access.=C2=A0 And this applies to all acces=
s by<br>
=C2=A0 =C2=A0a file system backed by a backing file.<br></blockquote><div><=
br></div><div>I think there&#39;s probably some confusion of terminology he=
re.=C2=A0buf-&gt;file is opened with the mounter&#39;s credentials, so we a=
re impersonating the mounter here. Perhaps the commit message could describ=
e that more clearly. Same for the previous patches mentioned.</div><div>=C2=
=A0</div></div></div>

--000000000000a4bfc106514a1f64--

