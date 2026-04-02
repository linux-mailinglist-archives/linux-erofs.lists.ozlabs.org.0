Return-Path: <linux-erofs+bounces-3161-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFn0J2DwzWkzjQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3161-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 06:28:16 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A038393F
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 06:28:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmTP7671Yz2yYK;
	Thu, 02 Apr 2026 15:28:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f2e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775104091;
	cv=pass; b=LxBXcERqPY123eUzgmpRo5icQPbyYLio24E686NYv8rHkxNmfJUt6a3zDlhf0BBrKCtscNVT2IrELXpQQHgajeNijIZ/mQ1okr6n8hNBcp94wgxG8qPB0EmIh+8en2rFtF5lSOEi2Wda12a0y91vdnEHVZAJjv4Asi/WB8H3E6k3FweRJPNvJePbG7UB0blYnaVrdUu6bXLYS/VAXnItDxM3AcMGWRUkB7jDEQt9zbf+s5RMgg8PiW5VMZHtaip7bgnv3EYmi6PlX6hGWeG6qip0xJz2iCWjgZ79Zauo3BSotFVXdWOBEDxwFSLAq5mHV06kQ1yYD5no3+V59yvZ8A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775104091; c=relaxed/relaxed;
	bh=k/JRiLvQRo5eVaGrsIr0D4imQcmpr9Ug42zLWxkIpn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHgx6RXnpUNy91IyFR4IJxPGXkqLrmYxQ1Z3cE75qahJKsTbEQ3RBvRtKmNbn1BaRLuPTnrI0HusyBFBW9QLOds13KuuZrkYvCzlif4TMSpZfNqTn16eiiq9jVe+rK2TriJy7J4GBu1EAD1xCh03HzSTi0PErD/U3thvGK9vhvK4LXoahNG0UFmrFiKluGQJtng4FnQ1XtNVJYg4RKqCq+ucfUizRqlsFa3grDIvWFzpOstf7MsH3d+oN9B728wMrn0MWzsXolOuPAod0FgDEzR5DVHNJagQ/YxQ1cYWEssokzH7VgAKf83q9ugUaN915bYGXb10edb7TSrrjz/cIA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TGzkz02d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TGzkz02d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmTP63CVRz2xfX
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 15:28:10 +1100 (AEDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-89f61c8070dso808806d6.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 21:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775104087; cv=none;
        d=google.com; s=arc-20240605;
        b=K+sEjaMAiPju9n0FmRrzON1aW12r+CkwN3AcYtJ2vjUqev9QTE9afE2ljMfwPSqr2U
         edH/dGn4qwPQK6mbJ1ZXG+WZCcmmkHL/HQEz29qVmeDbuizk7bjNydq1SgT6Asfb5k+e
         r9ttL82vY7u6ZcnhPsHru0FOAkqxwA4MUZ3QgGutU8eN65bIy8JEgOXnXsB9C3eVe1Zl
         cP1DPmifRm/uQedgZIxigQsnPkphGiqUO4iSJmsws4R7af0hwTn8jJTFRyQ9PrVipSik
         Ccl8NrW0Q7smRgtojB5J7m5vktnglhGlzJu4ofwxq8y/3QlgzwEaHYauDehrSnCqHLzy
         1JvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k/JRiLvQRo5eVaGrsIr0D4imQcmpr9Ug42zLWxkIpn4=;
        fh=ICN8XJFWmfFgnEfqHmHYO56Y23U36oAAn5bFJWMW/o0=;
        b=CMHoBVtzv9OLD1zJkTsnG/V4twLRaq9LOfViDhjDPdRlaxI1jQc2l5UBoak1Q+1LnL
         ycZM1YvI+/IFLNS/u66+xgbKBgwLpk7WLmGamgEppEqEw3q20gS4QJd3O8USc9Q4L78z
         WfHdfL6zZe+ABut9AWara5DCAG5F67E1Ww+3LZxkxtD6fhzf2pkl9T4Vx5cjsNM9fEav
         kdQj5qYYmgo+KgkMzgimQ4EGkvJPFnDbIMTYhW1axekAWFvOrZlwrgXm6HFw6/eIPwQy
         1wvLQHWWJd/c/5ZuwL47acosOqyqzd3BTSe48X1MjkzAjfWnjuZmIhPAMrkUHj01vTDJ
         78Kg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775104087; x=1775708887; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/JRiLvQRo5eVaGrsIr0D4imQcmpr9Ug42zLWxkIpn4=;
        b=TGzkz02dfY3hrs2eUasPRqbuImnaPs82Qfa/YMluBMJXeYg77r8c5J+Xradq78M/OX
         tQItMkmihJdmWlFNJ5f8qI+zCzVuI+O9B90vBPi3/yNmu0pdPs3JKB/SKQEJJ8q+QvjW
         Mc9yADfshWg1bqgRgTLZ/DSYqtZiWBj91Rj3mTOzcMBzyNY5wFi4MmNZiAW7pR2kegBk
         fOYcs7MRpITZdb4WCJLG99FXruny8AK5U4hAsJyxoLX76JtG3uGCw85EdPf5bcqNBPUu
         zICF8yR+VT+ClwofgAcPenmRsBelVBe5rzO2vAs2yQld1JdG5PmSZXHO0qQWHJ7I7FD0
         rqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775104087; x=1775708887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k/JRiLvQRo5eVaGrsIr0D4imQcmpr9Ug42zLWxkIpn4=;
        b=DmD1lAAqfR4SpVhtEakmLWBlaBZZGa6IFUwuoUVloVcgDqNdRFre9IpCB53MlBXdDG
         5lbSgsAiGOwIDOmFtuMqfOk0XchKqfGIHLLMDR38UaT8FhQmZlei6V+onWsJJ+9XE+zw
         D0O0m1GqdL0tZBYRBfXGUQxHmAJtEXSU7RDuUOd6HHfsoT2hmwmHy+31DWv+O5u7REgO
         0mgQ7s3oiJoGJlWVHTcSaLNG3ZfS5xquTFkuprUDtE21u1SKd9JxDsB1ORKsbSXkJ7yr
         tJ6f0CUFOAqgQOVg1B5pR8PWFv1ByArdR/dSLZhyQi/iZzeGducrvvIgCiZ1vfVQJCX/
         STwA==
X-Gm-Message-State: AOJu0Yyadc4fu23LlZkpBd/vJUvfJQluZ8WYooJdeX51GR2W9SJIaDtE
	yDIX4zugy0qaHYW3FWpdNxxuattBDVLeV+TDm0w8iyDumLKOCGWzHwCBFUr9VEB+Tvzq1W+2OiP
	1+25rx52W+f6kXED6RoFWy3cFPeMlLWE=
X-Gm-Gg: ATEYQzx6CXRJSAAmr1UcAiM90mEUiCYP7Nfo62l7Vy5Er8s84VzBUYsbGZx8dExjHFU
	dlm4ceAfUxPjELwwNTnF33MX0dt8SctYrVTWDrLBpP02DoX5ck6E2cqMyJBEKweSXA3+mnqPiz5
	YYMOlvq5BEugKfbxzQgIM1FUa8dYxfBXXxecbTywZzGL3Imjbyc1sT1Brwr//I/WTMn2243uzoe
	r9taEBMes3G1HW7jVm5wW1Ojy07aefMZDAoxWqAIvXGis0M9cYedf0z5irGgxOFlPxsPXPlCdZO
	Vfmchh2WFxOYh7NREOhpaJMEJzbxiWBsXcsEqNgiESoEupTrwpgjRIxGwojHoxltcxWh
X-Received: by 2002:a05:6214:5281:b0:8a4:c5:1b1b with SMTP id
 6a1803df08f44-8a437306f0dmr61040446d6.2.1775104087184; Wed, 01 Apr 2026
 21:28:07 -0700 (PDT)
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
References: <20260401194000.1-deepakpathik2005@gmail.com>
In-Reply-To: <20260401194000.1-deepakpathik2005@gmail.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Thu, 2 Apr 2026 09:58:08 +0530
X-Gm-Features: AQROBzBX3KBn-P8OvKkQJtKpQJ9MvM8KOVPHy5elUDj1zNIIcmM8aa1axcQExCE
Message-ID: <CAGSu4WN88r1+zZw8G7Y3S2oQ1MV3J9w+oWX-FeRQC=bYu8Ntdw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix fd leak in erofs_metamgr_init()
To: Deepak Pathik <deepakpathik2005@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3161-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:deepakpathik2005@gmail.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 254A038393F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 02 Apr 2026 01:10, Deepak Pathik wrote:
> +if (!m2gr->bmgr) {
> +close(m2gr->vf.fd);

erofs_io_close() does more than close(fd) =E2=80=94 it dispatches through
vf->ops->close(vf) if ops is set, and resets vf->fd to -1 afterward.
Using raw close() here skips both, which is incorrect.

Also, the if block is missing tab indentation.

Suggested fix:

if (!m2gr->bmgr) {
erofs_io_close(&m2gr->vf);
return -ENOMEM;
}

On Thu, 2 Apr 2026 at 01:10, Deepak Pathik <deepakpathik2005@gmail.com> wro=
te:
>
> In erofs_metamgr_init(), erofs_tmpfile() returns a file
> descriptor stored in m2gr->vf.fd. If the subsequent
> erofs_buffer_init() call fails, the function returns -ENOMEM
> without closing this file descriptor.
>
> The caller erofs_metadata_init() handles this failure at
> err_free, which only frees the m2gr struct. The fd is
> therefore leaked with no remaining reference to close it.
>
> The success path correctly cleans up via erofs_metamgr_exit(),
> which calls erofs_io_close(&m2gr->vf). Mirror that behaviour
> on the error path by closing the fd before returning.
>
> Signed-off-by: Deepak Pathik <deepakpathik2005@gmail.com>
> ---
>  lib/metabox.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/metabox.c b/lib/metabox.c
> index 12706aa..d55e787 100644
> --- a/lib/metabox.c
> +++ b/lib/metabox.c
> @@ -32,8 +32,10 @@ static int erofs_metamgr_init(struct erofs_sb_info *sb=
i,
>
>  m2gr->vf =3D (struct erofs_vfile){ .fd =3D ret };
>         m2gr->bmgr =3D erofs_buffer_init(sbi, 0, &m2gr->vf);
> - if (!m2gr->bmgr)
> +if (!m2gr->bmgr) {
> +close(m2gr->vf.fd);
>                 return -ENOMEM;
> +}
>         return 0;
>  }
> --
> 2.50.1
>
>
>

