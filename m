Return-Path: <linux-erofs+bounces-2778-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMf9FO3cuGlykQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2778-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:47:41 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612B72A3D0C
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:47:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZfZx4dl2z2yVP;
	Tue, 17 Mar 2026 15:47:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::72c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773722857;
	cv=pass; b=FoO4AKa7As4096Uu5+vV1OFxSGzVX97Y01gcvO6rQlB09kpdlzrPSbGXpZWJO6ie3pQ7dK0PdQhWXps4XzPeemWAZKfs1ixpvEv1DkKwPQgKXmvwz24ZrOXK8zZsWGX3AZZOEvXngRh/2ysBJw6YcQNRuZl11U36PJHfLprAGi5a4bCZT/SiyGccg3wS+aVVa9CIxxrCBjiAJeE3R3z3KdjNOjOqGrCv7Mm1U5I5Hl2V81LSOxrEiM+uUWezhhX/psFjUyvGkFZ1D4ny5kj+NctvyAkwcsHbjkGU89MhcJaqC/p9sLW4NHr/3DMBC9pSVrgocc/5EJGFfAw85gKRXQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773722857; c=relaxed/relaxed;
	bh=bViC5gylYzPKtzt+XitOodhEM19SvQAKAkrq4FqdrOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdOvvJeaSH7SCt30J/XbZRRLCe7PRez/pHNLGZzjCq9BAJkIEITlbS8t+DQz9EpjeKhSQZEQLkKWMgcezTxBuMwgMWigVp3jPFj5HrDB05eoXOeoN4nrBpLB7cF5ty5EV/wW7ic+vdKTpOm87cs/mK7r8S/mVgqLh27bjmNqQSQ1Yu5c4S36HJn/SM6ELsk0qBGe157Ya0F7ZR0JbGYFu4E8K/ykYSV2qPRsvCZzpzY2NCDpLSzHF6p9oa6K4vdw47/hezlHOOehv3dhtQUa+Yifzd7BsriIzww9zGit4M/NGtOIXSC0vPntRPiSBZsXv+U5X15IAo7kcBL5s1zCUQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=htyp+PrN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=htyp+PrN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZfZw3JMgz2xb3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 15:47:35 +1100 (AEDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-8cd75937d58so79907385a.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773722853; cv=none;
        d=google.com; s=arc-20240605;
        b=dhdjWXL2W5X3Rne/zxEAdHdu4fObnX2MyaBmPoCLbrO4EKDSCEi2d+TWz5sc4/yWMH
         spr+H+ry6zh47uhBxicQ2MnM3sugtDPEwlEuCcTCxXL6688GTbcYcGovAE5ghsDuYEBg
         BGUpU7lh3TLo8hIldpC0b9fQwdX1zuj07bcmujUUrd0uDe7h0elyOXy7Ak4axjZQ9ZIX
         cWeX7T27qSgPSk4ndTNrriqx6+wKG76gpcIWBOHgu+vLrJqnWn1l8kFuVFJgBdnQjl13
         AnX45JY2lgJlIn6xD3h7Ljpm/i7DQACFDMbjSvRoYPAmJl2q2FT67vHgDFxdRfn/lDjn
         ZcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bViC5gylYzPKtzt+XitOodhEM19SvQAKAkrq4FqdrOA=;
        fh=WJhIciIiNZdDmLC1ZQ8ngNos9wKcoX5v3UjHHDA3Xes=;
        b=UQ1cGUR+mU9mDCsTdiVLHOWVIkxQYPoOEZRIC6UnfpnlcnIRKGM3qUNgzMgFTKvvyF
         MURZgxeNLQmVVDCoccvLgacnwn1OmW4Ln8p/EyDJz4zJHjX95c2KfXFQhk6tpfj/FDiw
         V7xAy6dEIVwd6xOJbnk9NebMzBWN/vRJQld1rC9cFWaLiRZTjzSJTHUX3EnxUH3AmV0u
         r+LUvX+ACWT1K21UPq4tUYoeE7EtDD2uyTE0B3Ukvhw+soXaXyCvqm7X3s4H8hlrVCll
         Md+VI9/swC0SdtHu6H9/MdV4DLVsdXGmkH4rUoN5p05Iek9Czj8pXN2/shJeYfbTiC+A
         /yfQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773722853; x=1774327653; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bViC5gylYzPKtzt+XitOodhEM19SvQAKAkrq4FqdrOA=;
        b=htyp+PrNej3lAXUVSbJ408hWsJjKGr0Fhkd7HFAGgCX8SvCgIABdp2t69uJETC/GNC
         +ZyBzXsCMi4ofggOv+M6G7Emu5YJRZud2/4oX/U4bheCQgZ0hSGsjxeTMfr4hsUvwUH3
         TW+KBWhvuXa9XRCLJ1yKujBUEfM2J7uvB72FLmstHYqHnoIaNiXPs0hJZgEujJUl2859
         qibXAPm1T9NQFrq3tpe13jZaI3PQkI6VpRQQVSQLmUwO1D06HcNH3n3jzhmBRMoW9S0A
         Bo9cqTAtAGHsBmq6NR380uhQKFiH3/TTsoiw7BtB6SQkdjhXLyRJfRYNi5JsGfqFmEDS
         1Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773722853; x=1774327653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bViC5gylYzPKtzt+XitOodhEM19SvQAKAkrq4FqdrOA=;
        b=cUqFzqGdtXoIMGxVK+PS9f8Rh6z8yvEZmfmJBwRIgzpwxL2hKdYZRQGxtkwnTEI14w
         5mb9kW+6gjqiZT3BxJjWQ5eNn6HO6a36ZxdPY/yUis/kZJIWyHDBydEXGbNpcx1a8ziQ
         OZUAp09mcZz69q/2aLoXKT882ejuAzHbPjs/Ztaiw/l5ct9D4XnwMboRpGGAoCvq3vdN
         YkoWcCqjtuqMnHFAzKxBWlyq7Qm/bww/ziL5vGAubPPBIJwWbJqsyf95/J7RzZTtD8j1
         2WO/062LrlhyCoQ4ZfYFcVMOX2JV8OVuvmWwdwa78anYZsoWK4ZhwgQXYipDWHIV7Zv8
         7llA==
X-Gm-Message-State: AOJu0YyhDyFcxoZ3GlQoTYX2CklDHfsWsfGMv9bg7QQSZmc3ZAPadPAV
	63PgFPp2C09nnjqdUCERz5NF38K7E9kjatoTmTyOf3eYUlKUPUUJh44juJR4SVMMETt3U1XvqzN
	cG9efZicqZZyN+KTcmeyQzZKg/gT9mHv+26FFmjw=
X-Gm-Gg: ATEYQzzuPPWwS9nTtcc3mW0wNK7xG/E/uqlX/C2yEPzX0p0oCzad3Mxe8XQaqUS5kwp
	0DngfxNv/uO/jrCGR0Zqp2mQlm0flj9EdWuyMpZbGF/OH5Dd2KunXvRY3+5Z6aHIcyOgRqO761l
	OrKut4F2ca8w4QdN6py2QoA4YFwqPlkNROnm4kryeYMQLggOmK7JuPgCGVG3OgCONER4CDg995g
	iY4O2YYVLLKWBN6RSz0mn1E+rOK9mpHtYtLIqdnLI/iZ3ICxVZfUg1CgyrMJgntBSZFujG57Yzr
	EiWK3vH+0Vt6Ioxr9Hg2ciBxF2HcAWozKZs60xSC2j1HWdqu52FaC19uf3Jpzy39+ggR
X-Received: by 2002:a05:6214:6105:b0:89a:4f20:c1b0 with SMTP id
 6a1803df08f44-89a81cefb02mr140505886d6.1.1773722853024; Mon, 16 Mar 2026
 21:47:33 -0700 (PDT)
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
References: <20260316201919.41839-1-singhutkal015@gmail.com>
 <964b9ef0-388e-4b92-becf-2bd9094893db@linux.alibaba.com> <e0e651d1-3c78-4116-961b-0113bb8a0251@linux.alibaba.com>
In-Reply-To: <e0e651d1-3c78-4116-961b-0113bb8a0251@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Tue, 17 Mar 2026 10:17:26 +0530
X-Gm-Features: AaiRm51mpK9KcqcUFNb8PeM3ZANudrkCS1Pl15WV4tHtDPC_fE96bouv8NsBqWM
Message-ID: <CAGSu4WOs57V1WpLXOkWMZg2SzrFMqNqPc4c+fkqVgRqkhAz2Hg@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: validate h_shared_count in erofs_init_inode_xattrs()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000095a8de064d31083d"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2778-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: 612B72A3D0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000095a8de064d31083d
Content-Type: text/plain; charset="UTF-8"

Hi Gao Xiang,

Thank you for the review.

Understood, I will include a reproducible way in v2 for both patches.

I have also created a GitHub issue to track these patches:
https://github.com/erofs/erofs-utils/issues/47

v2 will follow shortly.

Best regards,
Utkal Singh

On Tue, 17 Mar 2026 at 08:10, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

>
>
> On 2026/3/17 10:16, Gao Xiang wrote:
> >
> >
> > On 2026/3/17 04:19, Utkal Singh wrote:
> >> erofs_init_inode_xattrs() reads h_shared_count directly from the on-disk
> >> xattr ibody header and uses it to size a heap allocation and drive a
> >> read loop without checking whether the implied shared xattr array fits
> >> within xattr_isize.
> >>
> >> A crafted EROFS image with a large h_shared_count but a minimal
> >> xattr_isize causes the subsequent loop to read shared xattr entries
> >> beyond the xattr ibody boundary, interpreting unrelated on-disk data
> >> as shared xattr IDs.  This affects every library consumer -- dump.erofs,
> >> erofsfuse, and the rebuild path (lib/rebuild.c) -- none of which call
> >> the fsck-only erofs_verify_xattr() before reaching this code.
> >
> > I don't think other than fsck tool, this must be checked, since it
> > won't cause any harmful behavior but the filesystem image is already
> > corrupted, and because of the corruption, the user should get the
> > corrupted result, but it still have no impact to the whole system
> > stablity.
>
> Nevertheless, I'm fine if we try to harden this part, but the commit
> message should clarify the impact: it actually has no stability impact
> out of those images.
>
> Also there are many threads with your contribution, it's hard for me
> to follow those threads, now.
>
> Would you mind raising a github issue
> https://github.com/erofs/erofs-utils/issues
>
> and list all your patches for merging (with meaningful topics are
> preferred) ?
>
> >
> >>
> >> Validate that h_shared_count fits within the available xattr body space
> >> before allocating or reading.  Use a division-based check to avoid any
> >> theoretical overflow in the multiplication.
> >
> > I don't think it will overflow according to the ondisk format.
> >
> >>
> >> The subtraction is safe because callers above already reject
> >> xattr_isize < sizeof(struct erofs_xattr_ibody_header).
> >
> > Please add a reproducible way.
> >
> >>
> >> Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
> >> ---
> >>   lib/xattr.c | 10 ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git a/lib/xattr.c b/lib/xattr.c
> >> index 565070a..6891812 100644
> >> --- a/lib/xattr.c
> >> +++ b/lib/xattr.c
> >> @@ -1182,6 +1182,16 @@ static int erofs_init_inode_xattrs(struct
> erofs_inode *vi)
> >>       ih = it.kaddr;
> >>       vi->xattr_shared_count = ih->h_shared_count;
> >> +    /* validate h_shared_count fits within xattr_isize */
> >> +    if (vi->xattr_shared_count >
> >> +        (vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) /
> >> +            sizeof(u32)) {
> >
> > Can we avoid division?
> >
> >> +        erofs_err("bogus h_shared_count %u (xattr_isize %u) @ nid
> %llu",
> >> +              vi->xattr_shared_count, vi->xattr_isize,
> >> +              vi->nid | 0ULL);
> >> +        erofs_put_metabuf(&it.buf);
> >> +        return -EFSCORRUPTED;
> >> +    }
> >>       vi->xattr_shared_xattrs = malloc(vi->xattr_shared_count *
> sizeof(uint));
> >>       if (!vi->xattr_shared_xattrs) {
> >>           erofs_put_metabuf(&it.buf);
> >
>
>

--00000000000095a8de064d31083d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gao Xiang,<br><br>Thank you for the review.<br><br>Unde=
rstood, I will include a reproducible way in v2 for both patches.<br><br>I =
have also created a GitHub issue to track these patches:<br><a href=3D"http=
s://github.com/erofs/erofs-utils/issues/47">https://github.com/erofs/erofs-=
utils/issues/47</a><br><br>v2 will follow shortly.<br><br>Best regards,<br>=
Utkal Singh</div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, 17 Mar 2026 at 08:10, Gao Xiang &l=
t;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@linux.alibaba.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><br>
<br>
On 2026/3/17 10:16, Gao Xiang wrote:<br>
&gt; <br>
&gt; <br>
&gt; On 2026/3/17 04:19, Utkal Singh wrote:<br>
&gt;&gt; erofs_init_inode_xattrs() reads h_shared_count directly from the o=
n-disk<br>
&gt;&gt; xattr ibody header and uses it to size a heap allocation and drive=
 a<br>
&gt;&gt; read loop without checking whether the implied shared xattr array =
fits<br>
&gt;&gt; within xattr_isize.<br>
&gt;&gt;<br>
&gt;&gt; A crafted EROFS image with a large h_shared_count but a minimal<br=
>
&gt;&gt; xattr_isize causes the subsequent loop to read shared xattr entrie=
s<br>
&gt;&gt; beyond the xattr ibody boundary, interpreting unrelated on-disk da=
ta<br>
&gt;&gt; as shared xattr IDs.=C2=A0 This affects every library consumer -- =
dump.erofs,<br>
&gt;&gt; erofsfuse, and the rebuild path (lib/rebuild.c) -- none of which c=
all<br>
&gt;&gt; the fsck-only erofs_verify_xattr() before reaching this code.<br>
&gt; <br>
&gt; I don&#39;t think other than fsck tool, this must be checked, since it=
<br>
&gt; won&#39;t cause any harmful behavior but the filesystem image is alrea=
dy<br>
&gt; corrupted, and because of the corruption, the user should get the<br>
&gt; corrupted result, but it still have no impact to the whole system<br>
&gt; stablity.<br>
<br>
Nevertheless, I&#39;m fine if we try to harden this part, but the commit<br=
>
message should clarify the impact: it actually has no stability impact<br>
out of those images.<br>
<br>
Also there are many threads with your contribution, it&#39;s hard for me<br=
>
to follow those threads, now.<br>
<br>
Would you mind raising a github issue<br>
<a href=3D"https://github.com/erofs/erofs-utils/issues" rel=3D"noreferrer" =
target=3D"_blank">https://github.com/erofs/erofs-utils/issues</a><br>
<br>
and list all your patches for merging (with meaningful topics are<br>
preferred) ?<br>
<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; Validate that h_shared_count fits within the available xattr body =
space<br>
&gt;&gt; before allocating or reading.=C2=A0 Use a division-based check to =
avoid any<br>
&gt;&gt; theoretical overflow in the multiplication.<br>
&gt; <br>
&gt; I don&#39;t think it will overflow according to the ondisk format.<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; The subtraction is safe because callers above already reject<br>
&gt;&gt; xattr_isize &lt; sizeof(struct erofs_xattr_ibody_header).<br>
&gt; <br>
&gt; Please add a reproducible way.<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Utkal Singh &lt;<a href=3D"mailto:singhutkal015@gma=
il.com" target=3D"_blank">singhutkal015@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 lib/xattr.c | 10 ++++++++++<br>
&gt;&gt; =C2=A0 1 file changed, 10 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/lib/xattr.c b/lib/xattr.c<br>
&gt;&gt; index 565070a..6891812 100644<br>
&gt;&gt; --- a/lib/xattr.c<br>
&gt;&gt; +++ b/lib/xattr.c<br>
&gt;&gt; @@ -1182,6 +1182,16 @@ static int erofs_init_inode_xattrs(struct e=
rofs_inode *vi)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih =3D it.kaddr;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vi-&gt;xattr_shared_count =3D ih-&g=
t;h_shared_count;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* validate h_shared_count fits within xattr_i=
size */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (vi-&gt;xattr_shared_count &gt;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (vi-&gt;xattr_isize - =
sizeof(struct erofs_xattr_ibody_header)) /<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sizeof(u32)) {<br>
&gt; <br>
&gt; Can we avoid division?<br>
&gt; <br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erofs_err(&quot;bogus =
h_shared_count %u (xattr_isize %u) @ nid %llu&quot;,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 vi-&gt;xattr_shared_count, vi-&gt;xattr_isize,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 vi-&gt;nid | 0ULL);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erofs_put_metabuf(&amp=
;it.buf);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFSCORRUPTED;<=
br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vi-&gt;xattr_shared_xattrs =3D mall=
oc(vi-&gt;xattr_shared_count * sizeof(uint));<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vi-&gt;xattr_shared_xattrs) {<=
br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erofs_put_m=
etabuf(&amp;it.buf);<br>
&gt; <br>
<br>
</blockquote></div>

--00000000000095a8de064d31083d--

