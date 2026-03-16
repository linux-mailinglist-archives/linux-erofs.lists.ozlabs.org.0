Return-Path: <linux-erofs+bounces-2737-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHUbAvvGt2kRVQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2737-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 10:01:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057D4296978
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 10:01:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ8GY3lsHz2xln;
	Mon, 16 Mar 2026 20:01:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::630" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773651701;
	cv=pass; b=bpaoWgiMEMSYnmfPVSQohlvdfuY+oCt082p3FXL1JwMpCsXlRvUACHzJgZP66sOzgK//aYws8Moqzp3YPn8wCliQ82aBYar6/0Gqna+fmKm8RWWiTdRM37sGHBAZZjv7HtjgiXKbNaL50u/Ogve/z2uhSKKtoD6crCflecSfTC/0TIcZKBTv36kmpW/SZNuPfGooNoo2ZxW2l5nb0OZnQSsqRf9x3zZIOs1pi86GRvR5sBzTX6xkt8rRIGSqSpBp6qsBabU08pAyban8XvkeS1Wl7rkRf5d/+0cdUtWGWdX0rAF9dP/79Wyy8nu3POYh/pARRdTkjMjPCCPefBT4ug==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773651701; c=relaxed/relaxed;
	bh=1t7SN9IxdsSavIP6Lr2T5GkT27H0d66LVmHBCm9ikZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QumtMvH18Teb3p0X8i6fg4CqK/JaqHV1aNiHFqoNnHmkUqZAJ7KuEBwb9E9LAtB0LsOZsWo5K+P0MmtE8k/W94pYyCorsYI8VygBe81xDcozPkUtuiu7TahDgf4u/45ZsBDLq2TMJhxK7glR+n/gqYsS1TI4/PslBGZ1hQX38IUffOSup/OGoeDbrqg5FiYdrbczI66OP2stBk3ax0ig1uTpGqQ3hgXNjoglGuTVjdCQB0D742/xhP4ZtnBrk65S4LZKzcJ38qO5k9dvqqeFxVLml2RLTnn+nXE/A8P7MDf2+gy4pMGGv4/a4PdMhfF5YAcol3t/HR3LFJIFaIwxAA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FzC+zlKX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FzC+zlKX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ8GX3clHz2xS5
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 20:01:39 +1100 (AEDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-b9431300833so648013366b.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 02:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773651696; cv=none;
        d=google.com; s=arc-20240605;
        b=NZss7mdIYPZo3KTWdIHHDDm5nKD9uL820AendoJgcIgK7jREEGOpvGQmrag5e4XCXr
         VdD/2C/l2YEk/zaR8mIfWAN9lgYUmcM6KOXKk/iC9lhhQu/vXd9CZuTaCb9rhuczXAUF
         kdGdE3fD+cDFvlfiu1M0B5U0aTJwtbVZX8sX1acyJRaejG329L/YJqvcT7Kx3esoNP9b
         hNRje0e+9jYChGVMrJao7By/wXKdnDbgaq9M3Q0fj58PZjZBQmBAbfJezpO8Q45D2XhM
         0i+pN4i8vAb+F4r2kobaVY8Hy+zvdn7ZUz8qYCQheZKKD2WmRK5sifMMMuldWF2biiUJ
         qGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1t7SN9IxdsSavIP6Lr2T5GkT27H0d66LVmHBCm9ikZo=;
        fh=rvLU5cqxHLQ4FCn+y1GNsYrrV/GXApVN/LNfnCxMGSI=;
        b=YyfwFFRCTinGzPC+DhiIwD3RCdWbWcboIEZy5z87rb7RBmW74jmr1HUvBtvTIVSrQJ
         ePVZL6yGWNS+ziaZDqORxTrDJTcsiszk1NeslUfX2HHqT3i7GMIxbj7/xOvuBXnNdS0f
         0z83IltnQLscQeDoIqm0nO6+I78uSkT5AqIB253HiLzw9Zwv77cnP0KFduEi1FemxgPZ
         AC/JUkFsXikpdIybFmmChs021d7h+PKF53YOHZHGxL9EPhh2ySq6BIZ0xQlBzsFqKb0m
         ZD1w4x4SxS2ZamDuB2lempD9oQJSTmio/OZ5ax1fDT+1Fo0YMlkC5xWuM92h7nBn+AtY
         8epQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651696; x=1774256496; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t7SN9IxdsSavIP6Lr2T5GkT27H0d66LVmHBCm9ikZo=;
        b=FzC+zlKXUtGyjT2ogqrVNenCtSzuflaRzVXS0s+w0XDqieEQFctWuySXbQUIbEJ/TU
         fdClAF8Yp26O8TaXygOirPcVt2IuLh8aK8KQF8IEALFdQdFKhSfWcQzlGrlDn2YzaQVU
         9vNkzfZ+nUgUKKYOe6sWbLsEnAURL4pT4d+FU7RmCwT329AXZgICrwbBOPZnVlrraLup
         D8XaDROtOfmtZBnP48G2PGi07jUM1q5rZ1m7ah/mxrE+yHD6rLrn3sDnJ6EbfQnONCs9
         D/psWM4ZG8vYYsMrrmVCaQyFStky2+o/pVuyF8QgQarAJQAX8Tc2SZee7k7yZGxDvKa4
         9SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651696; x=1774256496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1t7SN9IxdsSavIP6Lr2T5GkT27H0d66LVmHBCm9ikZo=;
        b=pE55NUG7M4I7F5tfeffd/AmKdxw0oTsjq5LlljGErYhxWez6HxcQLczfxkD0JQxenW
         qq0hUp0lOe8imdKrNXo2cyRj76gt41bJ3dYaVc6C3R2ax/Ft8pTS2rVRSaPReyAiML+i
         Xs3gFiA0e+A3ptCgV/x0VskZRrxjhiKTnQh4/CpfEwDrdAgajhJBlI1imp2I4/0m4He9
         +qIIMy9LSdApStVuFR5N9uxKJZbYxevjGWKZlYfOWKDO7e376z7CrYlRm2Fi0qaAvn7N
         rtHMVaGyZFC0XzE3RpgtElNtOHLJzUHu2Yrbkr+ccjduKuRhzd5VJ6iv6CqiN8M5eZvj
         Qo+w==
X-Gm-Message-State: AOJu0Yx+3QZ+ZMrtSx3M0jFFwLkVua5bigtafbJyh/OWXdcbTddQfiua
	+ll0xd0SBjGxvilNILxTJgbYJEurtTxLJPcNebm+DaUcP2LlGmHzKnPWWqZvXeit6PLtFifJ5Xp
	UKHIPJX4z87pu9xiNL7qJeXYKF9DszWMNC9pt38MUdQ==
X-Gm-Gg: ATEYQzyLhY7nwwayFjw677nIciKCgb/5VlCOS4pm72fA4TTP8yxuNPqJGjdRtCD5UAk
	lRLRrWT8YeyO9bkSJDOLBFZzox9eeZLdgNm0uwI0/X4SFFfUB2ruIBT5NmjV0PuoUPcLhlRQnBx
	GByivI2AyMfS1WeBdLayl3B9YgPrAb3VzRToEO1MUx5N5c8fhDK47hRk8BCXbD1pVtt+MBVPeOT
	0tW2IFRl2+gy6Vu097UBosTsNEpbQMpc6eC0WOei/0JNb2OF+YnUqUuEMKz42CDfCHe2cLqRd7Y
	JYqtXMuu
X-Received: by 2002:a17:907:9715:b0:b97:a153:97ce with SMTP id
 a640c23a62f3a-b97a15399bemr318366066b.11.1773651696174; Mon, 16 Mar 2026
 02:01:36 -0700 (PDT)
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
References: <20260315191422.1392-1-lasyaprathipati@gmail.com> <2d26643a-6830-4667-81fe-2f03ea031f6d@linux.alibaba.com>
In-Reply-To: <2d26643a-6830-4667-81fe-2f03ea031f6d@linux.alibaba.com>
From: Sri Lasya Prathipati <lasyaprathipati@gmail.com>
Date: Mon, 16 Mar 2026 14:31:23 +0530
X-Gm-Features: AaiRm52FpoYe4OFZeb8qSpaUR91fStPdEhxdaTrrtnsNmkxQ1b8xX2-RHbOkgeM
Message-ID: <CABDnCW=oYe0Ho_K7eSNj8xeNUrDMFwBzW8iB5n7MDmxV9NXQNQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix potential NULL pointer dereference
 in docker_config.c
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, ChengyuZhu6 <hudson@cyzhu.com>, gaoxiang25@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2737-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[lasyaprathipati@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:hudson@cyzhu.com,m:gaoxiang25@huawei.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lasyaprathipati@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 057D4296978
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gao,

Thank you for the feedback. I apologize for the formatting issues in
the first version.

I have sent a [PATCH v2] via git send-email to ensure the tabs and
formatting are preserved correctly. In the second version, I also
added an iterator increment to prevent a potential infinite loop when
an entry is NULL.

Hi Chengyu, please review the V2 version instead.

Best regards,
Sri Lasya

On Mon, Mar 16, 2026 at 10:05=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2026/3/16 03:14, Sri Lasya wrote:
> > Signed-off-by: Sri Lasya <lasyaprathipati@gmail.com>
> > ---
> >   lib/remotes/docker_config.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/remotes/docker_config.c b/lib/remotes/docker_config.c
> > index 00db1bb..b346ee8 100644
> > --- a/lib/remotes/docker_config.c
> > +++ b/lib/remotes/docker_config.c
> > @@ -38,7 +38,6 @@ static char *docker_config_path(void)
> >   {
> >       const char *dir;
> >       char *path =3D NULL;
> > -
> >       dir =3D getenv("DOCKER_CONFIG");
> >       if (dir) {
> >               if (!*dir)
> > @@ -203,6 +202,8 @@ int erofs_docker_config_lookup(const char *registry=
,
> >               }
> >
> >               entry =3D json_object_iter_peek_value(&it);
> > +                if (!entry)
> > +                     continue;
>
> The patch format is broken, also Chengyu could you review it?
>
> Thanks,
> Gao Xiang
>
> >               if (json_object_object_get_ex(entry, "auth", &auth_field)=
) {
> >                       b64 =3D json_object_get_string(auth_field);
> >                       if (b64 && *b64) {
>

