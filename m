Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BCCA2BC9F
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 08:45:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yq5c44xdQz30Tm
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 18:45:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738914323;
	cv=none; b=U3V9d0KjpOawMxK/HyaX/3BEXo7Eitskg/6dPZOqpOxJYSHVVRIBtd2A6d869kC/zYUxw7ytCAzHvLAzb9dn5Rr+K8uV1SGBLL1y28xsrw5t6udRCfZi3QIOCYQw8wRSRLuctrX5ihscJVVJNlwKb6vJ4QqPd1DUu3l57d+inCfj4W9goMoiDYLXOwWyOhhGT7DrAoyGQfqQfg9OQuv/ZAZm7QI+xUYK0yt0tgtG5ysQh+BV4TilTO3r+GIXJ0HeW8KlbsCSSkxDvojKl1Z4eY1kuctHmirxzf22bSgkDeAlvTxXinGXB72ukvknhdx6AFmB/rOAvCSDUdZCWySXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738914323; c=relaxed/relaxed;
	bh=vlhcGyG2f/unU6UaU+cT0C3is6AdEv1x10biGKQoIKU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Lk6QUCqV51bABLry4ZeHObD1WzlN5lgNYdlvIP0D093Qztlo0dMKf5k5PpkCyn+kgvywjSqNeikuKUlUV4FK9PQUpFi/IwcU09MftkVNvhMuQ/+D8JjXJk7NB5K0gDVJg/eWHCUNfZIqNTSSzfNf9nRROi+58AupzUtNYY57Y9FfKIFPd6VpzYKUwB6T3YGpi6QtgnI04MXN211QSUnAkygJTTlcUTnRBByEES/n64YqF4jwlaosADTmynCpu3pUUAfcT6MdBMbSQ+vazhYkgYyFfHj4oaHMY1/qh944pKaO0vkXFVtgTqlux0I9LejD/gT2HcCC/xqzPdPjqmV1fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jlxbx3mp; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jlxbx3mp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yq5c128kzz305Y
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Feb 2025 18:45:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738914315; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=vlhcGyG2f/unU6UaU+cT0C3is6AdEv1x10biGKQoIKU=;
	b=Jlxbx3mpz5IDu9h9MEF4eWBgejEt5JbsFAzmnk29H95ZRdMFWJx276PnbAj7WRucUvBQxRXPo1W4Cn6t6Rr8ErMt1JnjzE0WgGijETQA2G82lD0oSTWORRIERV5+PJ+GfyXeZVrltJp8zPm68V/Hh2baOZfmCOmyrRuNqR5d88U=
Received: from 30.221.129.238(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WOygAYO_1738914295 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 15:45:14 +0800
Content-Type: multipart/alternative;
 boundary="------------08eLEETUsb98HOB2MOqKr9mm"
Message-ID: <b4cc743e-542c-4601-972d-4301e9c9a405@linux.alibaba.com>
Date: Fri, 7 Feb 2025 15:44:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20250207064135.2249529-1-hongzhen@linux.alibaba.com>
 <7a9a2ead-88e5-4b53-9322-c649c92e73c2@huawei.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <7a9a2ead-88e5-4b53-9322-c649c92e73c2@huawei.com>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.
--------------08eLEETUsb98HOB2MOqKr9mm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/2/7 15:33, Hongbo Li wrote:
>
>
> On 2025/2/7 14:41, Hongzhen Luo wrote:
>> There's no need to enumerate each type. No logic changes.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   fs/erofs/zmap.c | 59 ++++++++++++++++++-------------------------------
>>   1 file changed, 22 insertions(+), 37 deletions(-)
>>
>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>> index 689437e99a5a..0ee78413bfd5 100644
>> --- a/fs/erofs/zmap.c
>> +++ b/fs/erofs/zmap.c
>> @@ -265,24 +265,20 @@ static int z_erofs_extent_lookback(struct 
>> z_erofs_maprecorder *m,
>>           if (err)
>>               return err;
>>   -        switch (m->type) {
>> -        case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>> +        if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>>               lookback_distance = m->delta[0];
>>               if (!lookback_distance)
>>                   goto err_bogus;
>>               continue;
>> -        case Z_EROFS_LCLUSTER_TYPE_PLAIN:
>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD2:
>> +        } else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
>>               m->headtype = m->type;
>>               m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
>>               return 0;
>> -        default:
>> -            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>> -                  m->type, lcn, vi->nid);
>> -            DBG_BUGON(1);
>> -            return -EOPNOTSUPP;
>>           }
>> +        erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>> +              m->type, lcn, vi->nid);
>> +        DBG_BUGON(1);
>> +        return -EOPNOTSUPP;
>
> May be it would be easier to understand if you put the exception 
> branch at the beginning. Such as:
>
> if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>   // return -EOPNOTSUPP;
> }
>
> if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>   // do something
> }
>
> // do something for other cases..
>
> This is also useful for other places. :)
>
> Thanks,
> Hongbo
>
Okay, I will send an improved version later.

Thanks,

Hongzhen

>>       }
>>   err_bogus:
>>       erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
>> @@ -329,35 +325,28 @@ static int 
>> z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>>       DBG_BUGON(lcn == initial_lcn &&
>>             m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
>>   -    switch (m->type) {
>> -    case Z_EROFS_LCLUSTER_TYPE_PLAIN:
>> -    case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>> -    case Z_EROFS_LCLUSTER_TYPE_HEAD2:
>> +    if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>> +        if (m->delta[0] != 1) {
>> +            erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", 
>> lcn, vi->nid);
>> +            DBG_BUGON(1);
>> +            return -EFSCORRUPTED;
>> +        }
>> +        if (m->compressedblks)
>> +            goto out;
>> +    } else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
>>           /*
>>            * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
>>            * rather than CBLKCNT, it's a 1 block-sized pcluster.
>>            */
>>           m->compressedblks = 1;
>> -        break;
>> -    case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>> -        if (m->delta[0] != 1)
>> -            goto err_bonus_cblkcnt;
>> -        if (m->compressedblks)
>> -            break;
>> -        fallthrough;
>> -    default:
>> -        erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", 
>> lcn,
>> -              vi->nid);
>> -        DBG_BUGON(1);
>> -        return -EFSCORRUPTED;
>> +        goto out;
>>       }
>> +    erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, 
>> vi->nid);
>> +    DBG_BUGON(1);
>> +    return -EFSCORRUPTED;
>>   out:
>>       m->map->m_plen = erofs_pos(sb, m->compressedblks);
>>       return 0;
>> -err_bonus_cblkcnt:
>> -    erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
>> -    DBG_BUGON(1);
>> -    return -EFSCORRUPTED;
>>   }
>>     static int z_erofs_get_extent_decompressedlen(struct 
>> z_erofs_maprecorder *m)
>> @@ -386,9 +375,7 @@ static int 
>> z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>>                   m->delta[1] = 1;
>>                   DBG_BUGON(1);
>>               }
>> -        } else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
>> -               m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
>> -               m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
>> +        } else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
>>               if (lcn != headlcn)
>>                   break;    /* ends at the next HEAD lcluster */
>>               m->delta[1] = 1;
>> @@ -452,8 +439,7 @@ static int z_erofs_do_map_blocks(struct inode 
>> *inode,
>>           }
>>           /* m.lcn should be >= 1 if endoff < m.clusterofs */
>>           if (!m.lcn) {
>> -            erofs_err(inode->i_sb,
>> -                  "invalid logical cluster 0 at nid %llu",
>> +            erofs_err(inode->i_sb, "invalid logical cluster 0 at nid 
>> %llu",
>>                     vi->nid);
>>               err = -EFSCORRUPTED;
>>               goto unmap_out;
>> @@ -469,8 +455,7 @@ static int z_erofs_do_map_blocks(struct inode 
>> *inode,
>>               goto unmap_out;
>>           break;
>>       default:
>> -        erofs_err(inode->i_sb,
>> -              "unknown type %u @ offset %llu of nid %llu",
>> +        erofs_err(inode->i_sb, "unknown type %u @ offset %llu of nid 
>> %llu",
>>                 m.type, ofs, vi->nid);
>>           err = -EOPNOTSUPP;
>>           goto unmap_out;
--------------08eLEETUsb98HOB2MOqKr9mm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025/2/7 15:33, Hongbo Li wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:7a9a2ead-88e5-4b53-9322-c649c92e73c2@huawei.com">
      <br>
      <br>
      On 2025/2/7 14:41, Hongzhen Luo wrote:
      <br>
      <blockquote type="cite">There's no need to enumerate each type. 
        No logic changes.
        <br>
        <br>
        Signed-off-by: Hongzhen Luo <a class="moz-txt-link-rfc2396E" href="mailto:hongzhen@linux.alibaba.com">&lt;hongzhen@linux.alibaba.com&gt;</a>
        <br>
        ---
        <br>
          fs/erofs/zmap.c | 59
        ++++++++++++++++++-------------------------------
        <br>
          1 file changed, 22 insertions(+), 37 deletions(-)
        <br>
        <br>
        diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
        <br>
        index 689437e99a5a..0ee78413bfd5 100644
        <br>
        --- a/fs/erofs/zmap.c
        <br>
        +++ b/fs/erofs/zmap.c
        <br>
        @@ -265,24 +265,20 @@ static int z_erofs_extent_lookback(struct
        z_erofs_maprecorder *m,
        <br>
                  if (err)
        <br>
                      return err;
        <br>
          -        switch (m-&gt;type) {
        <br>
        -        case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
        <br>
        +        if (m-&gt;type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
        <br>
                      lookback_distance = m-&gt;delta[0];
        <br>
                      if (!lookback_distance)
        <br>
                          goto err_bogus;
        <br>
                      continue;
        <br>
        -        case Z_EROFS_LCLUSTER_TYPE_PLAIN:
        <br>
        -        case Z_EROFS_LCLUSTER_TYPE_HEAD1:
        <br>
        -        case Z_EROFS_LCLUSTER_TYPE_HEAD2:
        <br>
        +        } else if (m-&gt;type &lt; Z_EROFS_LCLUSTER_TYPE_MAX) {
        <br>
                      m-&gt;headtype = m-&gt;type;
        <br>
                      m-&gt;map-&gt;m_la = (lcn &lt;&lt; lclusterbits) |
        m-&gt;clusterofs;
        <br>
                      return 0;
        <br>
        -        default:
        <br>
        -            erofs_err(sb, "unknown type %u @ lcn %lu of nid
        %llu",
        <br>
        -                  m-&gt;type, lcn, vi-&gt;nid);
        <br>
        -            DBG_BUGON(1);
        <br>
        -            return -EOPNOTSUPP;
        <br>
                  }
        <br>
        +        erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
        <br>
        +              m-&gt;type, lcn, vi-&gt;nid);
        <br>
        +        DBG_BUGON(1);
        <br>
        +        return -EOPNOTSUPP;
        <br>
      </blockquote>
      <br>
      May be it would be easier to understand if you put the exception
      branch at the beginning. Such as:
      <br>
      <br>
      if (m-&gt;type &gt;= Z_EROFS_LCLUSTER_TYPE_MAX) {
      <br>
        // return -EOPNOTSUPP;
      <br>
      }
      <br>
      <br>
      if (m-&gt;type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
      <br>
        // do something
      <br>
      }
      <br>
      <br>
      // do something for other cases..
      <br>
      <br>
      This is also useful for other places. :)
      <br>
      <br>
      Thanks,
      <br>
      Hongbo
      <br>
      <br>
    </blockquote>
    <p>Okay, I will send an improved version later.</p>
    <p>Thanks,</p>
    <p>Hongzhen<span
style="color: rgb(51, 51, 51); font-family: PingFangSC-Regular; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">
</span></p>
    <blockquote type="cite"
      cite="mid:7a9a2ead-88e5-4b53-9322-c649c92e73c2@huawei.com">
      <blockquote type="cite">      }
        <br>
          err_bogus:
        <br>
              erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid
        %llu",
        <br>
        @@ -329,35 +325,28 @@ static int
        z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
        <br>
              DBG_BUGON(lcn == initial_lcn &amp;&amp;
        <br>
                    m-&gt;type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
        <br>
          -    switch (m-&gt;type) {
        <br>
        -    case Z_EROFS_LCLUSTER_TYPE_PLAIN:
        <br>
        -    case Z_EROFS_LCLUSTER_TYPE_HEAD1:
        <br>
        -    case Z_EROFS_LCLUSTER_TYPE_HEAD2:
        <br>
        +    if (m-&gt;type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
        <br>
        +        if (m-&gt;delta[0] != 1) {
        <br>
        +            erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid
        %llu", lcn, vi-&gt;nid);
        <br>
        +            DBG_BUGON(1);
        <br>
        +            return -EFSCORRUPTED;
        <br>
        +        }
        <br>
        +        if (m-&gt;compressedblks)
        <br>
        +            goto out;
        <br>
        +    } else if (m-&gt;type &lt; Z_EROFS_LCLUSTER_TYPE_MAX) {
        <br>
                  /*
        <br>
                   * if the 1st NONHEAD lcluster is actually PLAIN or
        HEAD type
        <br>
                   * rather than CBLKCNT, it's a 1 block-sized pcluster.
        <br>
                   */
        <br>
                  m-&gt;compressedblks = 1;
        <br>
        -        break;
        <br>
        -    case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
        <br>
        -        if (m-&gt;delta[0] != 1)
        <br>
        -            goto err_bonus_cblkcnt;
        <br>
        -        if (m-&gt;compressedblks)
        <br>
        -            break;
        <br>
        -        fallthrough;
        <br>
        -    default:
        <br>
        -        erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid
        %llu", lcn,
        <br>
        -              vi-&gt;nid);
        <br>
        -        DBG_BUGON(1);
        <br>
        -        return -EFSCORRUPTED;
        <br>
        +        goto out;
        <br>
              }
        <br>
        +    erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu",
        lcn, vi-&gt;nid);
        <br>
        +    DBG_BUGON(1);
        <br>
        +    return -EFSCORRUPTED;
        <br>
          out:
        <br>
              m-&gt;map-&gt;m_plen = erofs_pos(sb,
        m-&gt;compressedblks);
        <br>
              return 0;
        <br>
        -err_bonus_cblkcnt:
        <br>
        -    erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn,
        vi-&gt;nid);
        <br>
        -    DBG_BUGON(1);
        <br>
        -    return -EFSCORRUPTED;
        <br>
          }
        <br>
            static int z_erofs_get_extent_decompressedlen(struct
        z_erofs_maprecorder *m)
        <br>
        @@ -386,9 +375,7 @@ static int
        z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder
        *m)
        <br>
                          m-&gt;delta[1] = 1;
        <br>
                          DBG_BUGON(1);
        <br>
                      }
        <br>
        -        } else if (m-&gt;type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
        <br>
        -               m-&gt;type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
        <br>
        -               m-&gt;type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
        <br>
        +        } else if (m-&gt;type &lt; Z_EROFS_LCLUSTER_TYPE_MAX) {
        <br>
                      if (lcn != headlcn)
        <br>
                          break;    /* ends at the next HEAD lcluster */
        <br>
                      m-&gt;delta[1] = 1;
        <br>
        @@ -452,8 +439,7 @@ static int z_erofs_do_map_blocks(struct
        inode *inode,
        <br>
                  }
        <br>
                  /* m.lcn should be &gt;= 1 if endoff &lt; m.clusterofs
        */
        <br>
                  if (!m.lcn) {
        <br>
        -            erofs_err(inode-&gt;i_sb,
        <br>
        -                  "invalid logical cluster 0 at nid %llu",
        <br>
        +            erofs_err(inode-&gt;i_sb, "invalid logical cluster
        0 at nid %llu",
        <br>
                            vi-&gt;nid);
        <br>
                      err = -EFSCORRUPTED;
        <br>
                      goto unmap_out;
        <br>
        @@ -469,8 +455,7 @@ static int z_erofs_do_map_blocks(struct
        inode *inode,
        <br>
                      goto unmap_out;
        <br>
                  break;
        <br>
              default:
        <br>
        -        erofs_err(inode-&gt;i_sb,
        <br>
        -              "unknown type %u @ offset %llu of nid %llu",
        <br>
        +        erofs_err(inode-&gt;i_sb, "unknown type %u @ offset
        %llu of nid %llu",
        <br>
                        m.type, ofs, vi-&gt;nid);
        <br>
                  err = -EOPNOTSUPP;
        <br>
                  goto unmap_out;
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------08eLEETUsb98HOB2MOqKr9mm--
