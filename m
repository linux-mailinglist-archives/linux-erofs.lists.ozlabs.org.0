Return-Path: <linux-erofs+bounces-2718-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MYaCkGWt2kMTQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2718-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 06:33:53 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DCB294CFF
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 06:33:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ3fh552Yz2xln;
	Mon, 16 Mar 2026 16:33:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f30" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773639228;
	cv=pass; b=VMhtiBLKvmJfLH4IM5odbLwK4c4dbW0c5sQcOZy8EEDvDBNoagw1CwcrLba2XnujNNTqEMIE31/qRPOnx9XABZS/YkLb6k4ntd2XUM9XF4F2gw7g5ZnjmXAtRKkl0WKb4gToUnub3oE21lZFeOhYwLgFe3Mep/1HULu51n4DFNUqcSuEXPfL7DCir17yz1wdAUUhqjOMe22d2qUvsthzMwLd6/fL6RDov7K37V+cn5ImkF1ttjGh6lpmvWo7ZB+gtFNtUnysGBp55cAe8qLnwmR628SZ5zW6TUD2r8wNd7HuM6PbxKP7A2WoGwZLQ1TGJHqQ9lMJecr61U0p7bNhLw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773639228; c=relaxed/relaxed;
	bh=w1we7W8nJrPen+IUgCx7pZ2UGJFpaXAty3M0b22+9eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJOBS3ukIxfqzG2vBP29oNJrydg+9dLjKrSjmzegkY+yMYB9nvwHRLusI0C7UFsnjiBEm1KTI2tzaaaPY/X2B+IJitTBiWxeZUaI+9gSYg+RxJEzAVqd9cyisLsB1VKTIKwEgaRTTBHD3/z6VCiY7fnU+gmm7clkvWeplL0KWGVFe1sokp1zG7O/zk0Y5RDZd7NgCoxmSwSyY00eKsZPWDmKKX3cCIWg5V90L7uD48Hooc1o+uP9b/8PLU/cXu36mDgX81wh/c1KBRDt//un9+fNUVX2QXjZRuLm3o7tYkh5dJGIi74LgKGO6DS17pbUSQhZUWDSEb4/9uldDNcIWg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f7uizNDQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f7uizNDQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ3fg2fdqz2xlP
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 16:33:46 +1100 (AEDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-89a00dd0571so3469966d6.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 22:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773639223; cv=none;
        d=google.com; s=arc-20240605;
        b=ARbES2afAWwRtZLsHAGnGxbt7BCSGE7LJTIU/j4xloi2wyPqoUFD62vikTRUKcwU/q
         vRD05jE88P7EhlotjR7r1mddqAFTsHn4uTL7sdJMM7KuCLDsE+gmzbEih32NoMbrSkV+
         zVHH39x4H2JArlCViUKEFaxjAYM7cThRVAw0wVEg/BwGiho0W14z1j1p6e7jEcZDKIRd
         exTsBhQNNKTgLnw7dKfol9Sa9Z/pTFZP/7CbBlqUijaiEmwnr2ds392/4TLUX3Vgtmbu
         D4VTaxbmanIFDpAvRoEqbmdEkNqIwpEMiOhx2l//PHlxEk/OHGsxxX/xueKik3Nbh0gV
         7HOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=w1we7W8nJrPen+IUgCx7pZ2UGJFpaXAty3M0b22+9eQ=;
        fh=5dXT8ioBg+aJkWrC2NiwjDzoRkacE+TIGJEZ/x6T9XM=;
        b=Xj2vFNQgXhl3aONriTnFox4tCoZr7TuLn2jYp2+UOwwOYzQvLqqkHp/aZOB0waL2p+
         Z2T01dUoyns9M/JTPQcunWqr6Lkisw8n/dbm/5QwRYBYqTzmPOZKL9Aw+mDS1grJDiz7
         EPmf75VulaloNHTl9NkyCUu2bB+ipvbm7HIyr2415Hi95Zgw6fpB6BwZ/pX7dN/XsaZp
         LG0KeNI3H/bTPChTEFzRVktwKibLNZZ5cFn0jDjvBQVRNJvmxZKOo4j4E0ut572Xqe01
         WDKcqatNVm+CpCwsK13ohHz9Rlure60v/Kj3WlQLsgBuUzaner3fPNvv92l1pKQ/xvRL
         MiCQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773639223; x=1774244023; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w1we7W8nJrPen+IUgCx7pZ2UGJFpaXAty3M0b22+9eQ=;
        b=f7uizNDQZ8Zshb3xu6kiJ7F8uIyOQdLmE5iQ1Z5jB6olcqA5mscYq+zfEhR/WPMJHv
         8tc50LnIkjNScGyzN5Gu0Z8a2+CXXIE8QPSFZqvnJFKNjPldh5bSpgi6gQimIuMYV2ZO
         3D12SxA+SRKa7ror4FQ7I3b4bE+P6QkSs+SZpL8uIr74XdcbK6ksAuZBY6oRfQ46rz+B
         VYaA3FfPkmTurfQHY/1z2aFdcqY4t1xlkP4towg7PFOryKU/oc7YID9PGs8Gt1LvU7lo
         S3PEfuhmowck6YHO9NqZMpvkZ/n+fP8Hy82suCqMurtGCAnsQwxxLmCobat4i88sLvTY
         TN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773639223; x=1774244023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1we7W8nJrPen+IUgCx7pZ2UGJFpaXAty3M0b22+9eQ=;
        b=rDiP5+pCS9W85gDht4RUb91uAYNyUjP0JfBeWWXz3QMnG/84qUdi1lrdE3YNVwIil/
         BUhzfI3fW5cSEuHNVxMUyt+KZsp9Xkd7tzv2Mo+Abh1icYafds4DBOQTlv/Vp6NUUoxW
         i3E6ZRkncIyyrohER+mB7M9KASFUr/HXUg/wz11bJphrxElmotdeykQpNT2YdmMlzOYT
         8WBzcF/vwDOkAMYVAFeF62yxjBadgXm5J2ASQNCnxBRzB9WH6pGcpWk+0DsDsVz/QD5R
         isURNweKyoaR3614uUnFtDlkhMHB9K0pXsfuqZRED9pO9rVW9uaBK2KuqQLzcqxaJG6/
         KlvA==
X-Forwarded-Encrypted: i=1; AJvYcCV3GbXdYJdqEgalv1GcDwBfKU/iudyRk1F4OIRgjx3kbcXv+88no6YUpRgiTSsXgDm004qIhkOv3P3DJQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxikBq7ow+qg26+83fWJMLOXsHl2Fi0X9/XKSROV9rnxPg1zsZj
	QR0JcAfjX5cpIWZFDQoqlRlI2DBw8RDCosHIxmGbVYc85pmM6sZyDnCic6AsMWoEuFueYEqiK5W
	DyYJ6qOoAx+XrJo9EAHnCA6RQV1Nonw8=
X-Gm-Gg: ATEYQzyC16AGXua5jNNuUPTnmAYjbJGaqaRKwbfIxpPCd8DIayhQs97UbY2fRPi6Acu
	ifj40AHXHnAr5zNmmEnCCbRQxmGIiKaNRVgSkl1+Fw36mh6onu2/JlLdipd34ywLpqW2ZWSypem
	2Q/PYZZDsShcuVtvVddHhaMDtRlPHxIyqJ+y9Oym/ymsn+kI5Iogzl69aBt9qogUwrWsCnszpTj
	B1sZyU6IKKgYP8pLG9jDGkRN9PfEZM8+/pVhVXfdIgTKD9mDGw5QEmtdZ1XA65MFqa1+q0Ya0Mi
	av1xu90jVcGjgGG6xX6mZVqfQ6a0aEBbDRMTSRJSW9yJzchtf3XyPVkmWe7sFXEkzURotw==
X-Received: by 2002:a05:622a:509:b0:509:47e2:9dfd with SMTP id
 d75a77b69052e-50957e67f38mr125046721cf.9.1773639223432; Sun, 15 Mar 2026
 22:33:43 -0700 (PDT)
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
References: <20260315072806.17504-1-singhutkal015@gmail.com>
 <20260315142249.4333-1-singhutkal015@gmail.com> <tencent_36163BB497CDB8AD5A2D8BD11B3DFBB80E0A@qq.com>
In-Reply-To: <tencent_36163BB497CDB8AD5A2D8BD11B3DFBB80E0A@qq.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Mon, 16 Mar 2026 11:03:36 +0530
X-Gm-Features: AaiRm52L1yFHx_LPiqTZIOqti8OF4dviLFNYGldjASUKfde1DSbm3fm6Oi2UInE
Message-ID: <CAGSu4WMDXwzN3Uw0c496ZE-5kWQv1_=yVY7PRr-3vJ-g9os=FA@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: lib: validate algorithm for encoded extents
To: Yifan Zhao <yifan.yfzhao@foxmail.com>
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000df5a6f064d1d8fcd"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2718-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[foxmail.com];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yifan.yfzhao@foxmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 49DCB294CFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000df5a6f064d1d8fcd
Content-Type: text/plain; charset="UTF-8"

Hi Yifan,

Thank you for the guidance and for clarifying the review workflow.

Understood. I will consolidate related fixes into proper patch
series with a cover letter in future submissions instead of
sending individual patches.

I will also follow the versioning conventions (v2/v3 for updates
and RESEND for unchanged resubmissions) and adopt the backport
commit message format described in commit ee2709, including
square bracket annotations where applicable.

Thanks again for the review and suggestions.

Best regards,
Utkal Singh

On Mon, 16 Mar 2026 at 08:41, Yifan Zhao <yifan.yfzhao@foxmail.com> wrote:

> Hi Utkal Singh,
> Thank you for your contributions and the recent fixes.
> To help us manage the review process more effectively and avoid confusion
> with duplicate emails,
> could you please consolidate these random fixes into a *single patch
> series with a cover letter* in the future?
> This allows us to track the entire set of changes in one thread.
> Additionally, please follow these conventions for follow-ups:
>
>    1. *Versioning:* If you modify a patch based on review feedback,
>    please increment the version prefix (e.g., v2, v3) in the subject line.
>    2. *Resends:* If you are simply resending a patch without changes
>    (e.g., to bump it), please add a *RESEND* prefix to the subject line
>    instead of treating it as a new version.
>
> This will greatly help in tracking which patches need to be merged.
> Regarding backporting patches to the kernel, please refer to commit ee2709
> in the erofs-utils repository for the preferred commit message format.
> Specifically, please use square brackets [] to describe any modifications
> you made to the source kernel commit during the backport process.
> [ Gao may follow up with additional workflow details if needed. ]
> Thanks again for your help.
>
> Yifan Zhao
>
>
> On 3/15/2026 10:22 PM, Utkal Singh wrote:
>
> Encoded extents use fmt field as algorithm index without checking
> available_compr_algs bitmask. The non-encoded path already has this
> check but the encoded extent path in z_erofs_map_blocks_ext() was
> missing equivalent validation.
>
> Add available_compr_algs consistency check for encoded extents,
> following kernel commit 131897c65e2b.
>
> Signed-off-by: Utkal Singh <singhutkal015@gmail.com> <singhutkal015@gmail.com>
> ---
>  lib/zmap.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 0e7af4e..a8d1ca6 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -630,8 +630,17 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
>  			if (map->m_plen & Z_EROFS_EXTENT_PLEN_PARTIAL)
>  				map->m_flags |= EROFS_MAP_PARTIAL_REF;
>  			map->m_plen &= Z_EROFS_EXTENT_PLEN_MASK;
> -			if (fmt)
> -				map->m_algorithmformat = fmt - 1;
> +			if (fmt) {
> +				unsigned int afmt = fmt - 1;
> +
> +				if (afmt >= Z_EROFS_COMPRESSION_MAX ||
> +				    !(sbi->available_compr_algs & (1 << afmt))) {
> +					erofs_err("unknown algorithm %u for encoded extent, nid %llu",
> +						  afmt, vi->nid | 0ULL);
> +					return -EOPNOTSUPP;
> +				}
> +				map->m_algorithmformat = afmt;
> +			}
>  			else if (interlaced && !((map->m_pa | map->m_plen) & bmask))
>  				map->m_algorithmformat =
>  					Z_EROFS_COMPRESSION_INTERLACED;
>
>

--000000000000df5a6f064d1d8fcd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Yifan,<br><br>Thank you for the guidance and for clarif=
ying the review workflow.<br><br>Understood. I will consolidate related fix=
es into proper patch <br>series with a cover letter in future submissions i=
nstead of <br>sending individual patches.<br><br>I will also follow the ver=
sioning conventions (v2/v3 for updates <br>and RESEND for unchanged resubmi=
ssions) and adopt the backport <br>commit message format described in commi=
t ee2709, including <br>square bracket annotations where applicable.<br><br=
>Thanks again for the review and suggestions.<br><br>Best regards,<br>Utkal=
 Singh</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, 16 Mar 2026 at 08:41, Yifan Zhao &lt;=
<a href=3D"mailto:yifan.yfzhao@foxmail.com">yifan.yfzhao@foxmail.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

 =20
   =20
 =20
  <div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">Hi Utkal Singh,</span></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">
</span></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">Thank you for your contributions and the recent fixes.</sp=
an></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">
</span></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">To help us manage the review process more effectively and =
avoid confusion with duplicate emails,</span></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">could you please consolidate these random fixes into a </s=
pan><strong style=3D"margin:0px;padding:0px;box-sizing:border-box;border-wi=
dth:0px;border-style:solid;border-color:rgb(227,227,227);font-weight:600"><=
span style=3D"margin:0px;padding:0px;box-sizing:border-box;border-width:0px=
;border-style:solid;border-color:rgb(227,227,227)">single patch series with=
 a cover letter</span></strong><span style=3D"margin:0px;padding:0px;box-si=
zing:border-box;border-width:0px;border-style:solid;border-color:rgb(227,22=
7,227)"> in the future?</span></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">This allows us to track the entire set of changes in one t=
hread.</span></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">
</span></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">Additionally, please follow these conventions for follow-u=
ps:</span></div>
    <ol start=3D"1" dir=3D"auto" style=3D"margin:1rem 0px;padding:0px 0px 0=
px 1.625em;box-sizing:border-box;border-width:0px;border-style:solid;border=
-color:rgb(227,227,227);color:rgb(29,29,31);font-family:system-ui,ui-sans-s=
erif,-apple-system,BlinkMacSystemFont,Inter,NotoSansHans,sans-serif;font-si=
ze:16px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;word-spacing:0px;white-space:pre-line;background-colo=
r:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:init=
ial"><li style=3D"margin:0px;padding:0px;box-sizing:border-box;border-width=
:0px;border-style:solid;border-color:rgb(227,227,227);unicode-bidi:plaintex=
t"><strong style=3D"margin:0px;padding:0px;box-sizing:border-box;border-wid=
th:0px;border-style:solid;border-color:rgb(227,227,227);font-weight:600"><s=
pan style=3D"margin:0px;padding:0px;box-sizing:border-box;border-width:0px;=
border-style:solid;border-color:rgb(227,227,227)">Versioning:</span></stron=
g><span style=3D"margin:0px;padding:0px;box-sizing:border-box;border-width:=
0px;border-style:solid;border-color:rgb(227,227,227)"> If you modify a patc=
h based on review feedback, please increment the version prefix (e.g., v2, =
v3) in the subject line.</span></li><li style=3D"margin:0px;padding:0px;box=
-sizing:border-box;border-width:0px;border-style:solid;border-color:rgb(227=
,227,227);unicode-bidi:plaintext"><strong style=3D"margin:0px;padding:0px;b=
ox-sizing:border-box;border-width:0px;border-style:solid;border-color:rgb(2=
27,227,227);font-weight:600"><span style=3D"margin:0px;padding:0px;box-sizi=
ng:border-box;border-width:0px;border-style:solid;border-color:rgb(227,227,=
227)">Resends:</span></strong><span style=3D"margin:0px;padding:0px;box-siz=
ing:border-box;border-width:0px;border-style:solid;border-color:rgb(227,227=
,227)"> If you are simply resending a patch without changes (e.g., to bump =
it), please add a </span><strong style=3D"margin:0px;padding:0px;box-sizing=
:border-box;border-width:0px;border-style:solid;border-color:rgb(227,227,22=
7);font-weight:600"><span style=3D"margin:0px;padding:0px;box-sizing:border=
-box;border-width:0px;border-style:solid;border-color:rgb(227,227,227)">RES=
END</span></strong><span style=3D"margin:0px;padding:0px;box-sizing:border-=
box;border-width:0px;border-style:solid;border-color:rgb(227,227,227)"> pre=
fix to the subject line instead of treating it as a new version.</span></li=
></ol>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">This will greatly help in tracking which patches need to b=
e merged.</span></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">
</span></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial">Regarding backporting patches to th=
e kernel, please refer to commit ee2709 in the erofs-utils repository for t=
he preferred commit message format.</div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial">Specifically, please use square bra=
ckets [] to describe any modifications you made to the source kernel commit=
 during the backport process.</div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial">[ Gao may follow up with additional=
 workflow details if needed. ]</div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">
</span></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"></div>
    <div style=3D"margin:1rem 0px;padding:0px;box-sizing:border-box;border-=
width:0px;border-style:solid;border-color:rgb(227,227,227);color:rgb(29,29,=
31);font-family:system-ui,ui-sans-serif,-apple-system,BlinkMacSystemFont,In=
ter,NotoSansHans,sans-serif;font-size:16px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:pre-line;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"margin:0px;padding:0=
px;box-sizing:border-box;border-width:0px;border-style:solid;border-color:r=
gb(227,227,227)">Thanks again for your help.</span></div>
    <p>Yifan Zhao</p>
    <p><br>
    </p>
    <div>On 3/15/2026 10:22 PM, Utkal Singh
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>Encoded extents use fmt field as algorithm index without checkin=
g
available_compr_algs bitmask. The non-encoded path already has this
check but the encoded extent path in z_erofs_map_blocks_ext() was
missing equivalent validation.

Add available_compr_algs consistency check for encoded extents,
following kernel commit 131897c65e2b.

Signed-off-by: Utkal Singh <a href=3D"mailto:singhutkal015@gmail.com" targe=
t=3D"_blank">&lt;singhutkal015@gmail.com&gt;</a>
---
 lib/zmap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 0e7af4e..a8d1ca6 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -630,8 +630,17 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *=
vi,
 			if (map-&gt;m_plen &amp; Z_EROFS_EXTENT_PLEN_PARTIAL)
 				map-&gt;m_flags |=3D EROFS_MAP_PARTIAL_REF;
 			map-&gt;m_plen &amp;=3D Z_EROFS_EXTENT_PLEN_MASK;
-			if (fmt)
-				map-&gt;m_algorithmformat =3D fmt - 1;
+			if (fmt) {
+				unsigned int afmt =3D fmt - 1;
+
+				if (afmt &gt;=3D Z_EROFS_COMPRESSION_MAX ||
+				    !(sbi-&gt;available_compr_algs &amp; (1 &lt;&lt; afmt))) {
+					erofs_err(&quot;unknown algorithm %u for encoded extent, nid %llu&quo=
t;,
+						  afmt, vi-&gt;nid | 0ULL);
+					return -EOPNOTSUPP;
+				}
+				map-&gt;m_algorithmformat =3D afmt;
+			}
 			else if (interlaced &amp;&amp; !((map-&gt;m_pa | map-&gt;m_plen) &amp; =
bmask))
 				map-&gt;m_algorithmformat =3D
 					Z_EROFS_COMPRESSION_INTERLACED;
</pre>
    </blockquote>
  </div>

</blockquote></div>

--000000000000df5a6f064d1d8fcd--

